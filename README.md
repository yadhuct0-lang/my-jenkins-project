# AWS Login Authentication Application

A simple web-based authentication application built using **FastAPI, AWS DynamoDB, Nginx, and Amazon EC2**.

The application provides a login page where users enter their credentials. The FastAPI backend validates the credentials against user records stored in DynamoDB and returns the appropriate authentication response.

## Architecture

```text
User
  │
  ▼
Nginx (EC2)
  │
  ├── Frontend
  │     └── Login.html
  │
  ▼
FastAPI Backend
  │
  ▼
Amazon DynamoDB
  │
  └── User_Ticket
```

## Technologies Used

* Python
* FastAPI
* Uvicorn
* Boto3
* Amazon DynamoDB
* Amazon EC2
* Nginx
* AWS CodeBuild
* Bash
* HTML / CSS / JavaScript
* Git / GitHub

## Project Structure

```text
.
├── app.py
├── build.sh
├── buildspec.yml
├── README.md
└── web/
    ├── Login.html
    ├── Dashboard.html
    └── Auth_Failure.html
```

## Application Flow

1. The user opens the login page hosted by Nginx on the EC2 instance.
2. The user enters their username and password.
3. JavaScript sends the credentials to the FastAPI `/login` endpoint.
4. FastAPI receives the request and queries the `User_Ticket` DynamoDB table.
5. The username is used as the DynamoDB key.
6. The stored password is compared with the submitted password.
7. If the credentials are valid, the user is redirected to `Dashboard.html`.
8. If the credentials are invalid, the user is redirected to `Auth_Failure.html`.

## Backend

The backend is implemented using FastAPI.

### Login Endpoint

```text
POST /login
```

### Request

```json
{
  "username": "example",
  "password": "password"
}
```

### Successful Response

```json
{
  "status": "success"
}
```

### Failed Response

```json
{
  "status": "failure"
}
```

## DynamoDB

The application uses an Amazon DynamoDB table named:

```text
User_Ticket
```

The table uses:

```text
User_Name
```

as the key used to retrieve a user.

The application expects user records to contain a password attribute:

```text
User_Name
Password
```

Example:

```text
User_Name: testuser
Password: example-password
```

## Frontend

The frontend contains three HTML pages:

### Login.html

Provides the login form and sends the credentials to the backend using JavaScript `fetch()`.

### Dashboard.html

Displayed after successful authentication.

### Auth_Failure.html

Displayed when authentication fails.

## Deployment

The frontend files are deployed to an Amazon EC2 instance running Nginx.

The deployment script:

1. Sets permissions on the SSH private key.
2. Configures SSH.
3. Copies the frontend files to the Nginx web directory.
4. Restarts Nginx.

Example deployment command:

```bash
scp -i KUBE-INFRA-KP.pem web/* ubuntu@<EC2-IP>:/usr/share/nginx/html/
```

Nginx is then restarted:

```bash
ssh -i KUBE-INFRA-KP.pem ubuntu@<EC2-IP> 'sudo systemctl restart nginx'
```

## AWS CodeBuild

The project uses AWS CodeBuild with the following build phases:

### Install

Initializes the build environment.

### Pre-build

Makes the deployment script executable.

```bash
chmod +x build.sh
```

### Build

Runs the deployment script.

```bash
sh -x build.sh
```

The `buildspec.yml` file controls the CodeBuild process.

## Configuration

The FastAPI application currently uses the AWS Mumbai region:

```text
ap-south-1
```

The DynamoDB table is:

```text
User_Ticket
```

For production environments, these values should ideally be configured using environment variables instead of being hard-coded.

## Security Considerations

This project is intended as a learning/deployment project and should be improved before being used in a production environment.

### Do not commit private keys

The EC2 private key must **never** be committed to GitHub.

Add the key to `.gitignore`:

```text
*.pem
```

### Password Security

Passwords should not be stored as plain text in DynamoDB.

A production authentication system should use secure password hashing and a proper authentication mechanism.

### SSH Security

The current deployment configuration disables SSH host-key verification:

```text
StrictHostKeyChecking no
UserKnownHostsFile=/dev/null
```

This is convenient for automation but is not recommended for production environments.

### Credentials

AWS credentials should be provided through IAM roles or secure environment/configuration mechanisms rather than being hard-coded.

## Future Improvements

Possible improvements include:

* Password hashing
* HTTPS/SSL configuration
* JWT or session-based authentication
* Environment variables for configuration
* IAM roles instead of SSH keys where possible
* Secure SSH host-key verification
* AWS Secrets Manager or Parameter Store
* Automated CI/CD pipeline
* Better error handling
* Input validation using Pydantic models
* Authentication logging and monitoring
* Restricting EC2 security-group access
* Running FastAPI behind Nginx using Uvicorn/Gunicorn

## Disclaimer

This project is primarily intended for learning and demonstrating a basic AWS-based application deployment workflow using FastAPI, DynamoDB, EC2, Nginx, and CodeBuild.
