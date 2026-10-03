# Jenkins CI/CD Pipeline for AWS Web Application Deployment

## Project Overview

This project demonstrates the deployment of a web application using Jenkins for CI/CD automation and AWS infrastructure. The application uses FastAPI for backend authentication, Amazon DynamoDB for user data storage, and Nginx to serve the frontend on an Amazon EC2 instance.

The deployment process uses Bash scripting and SSH/SCP to transfer frontend files to the EC2 server.

## Tech Stack

* **CI/CD:** Jenkins
* **Version Control:** Git, GitHub
* **Cloud Platform:** Amazon Web Services (AWS)
* **Compute:** Amazon EC2
* **Database:** Amazon DynamoDB
* **Backend:** Python, FastAPI, Boto3
* **Web Server:** Nginx
* **Frontend:** HTML, CSS, JavaScript
* **Automation:** Bash, SSH, SCP

## Architecture

```text
Developer
    |
    v
GitHub Repository
    |
    v
Jenkins CI/CD Pipeline
    |
    v
Build / Deployment Script
    |
    | SSH / SCP
    v
Amazon EC2 Instance
    |
    +-- Nginx --> Frontend
    |
    +-- FastAPI --> DynamoDB
```

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

## Application Features

* User login interface built with HTML, CSS, and JavaScript.
* REST API developed using FastAPI.
* User record retrieval from Amazon DynamoDB using Boto3.
* Login success and failure responses.
* Frontend deployment to an EC2 instance running Nginx.
* Shell scripting for deployment automation.

## CI/CD Workflow

1. Application source code is maintained in GitHub.
2. Jenkins is used to automate the CI/CD workflow.
3. The deployment script prepares SSH access to the EC2 instance.
4. SCP transfers frontend files to the Nginx web directory.
5. Nginx is restarted to apply the deployment.
6. The deployed frontend communicates with the backend API, which retrieves user records from DynamoDB.

*The exact pipeline triggers and stages depend on the Jenkins job configuration.*

## AWS Configuration

The application connects to AWS using Boto3 with the following configuration:

* **AWS Region:** `ap-south-1` (Mumbai)
* **DynamoDB Table:** `User_Ticket`
* **DynamoDB Key:** `User_Name`
* **Deployment Target:** Amazon EC2
* **Web Server Directory:** `/usr/share/nginx/html/`

AWS permissions must allow the application to access the DynamoDB table.

## Deployment

The deployment script uses SSH and SCP to transfer frontend files to the EC2 instance.

Example:

```bash
scp -i KUBE-INFRA-KP.pem web/* \
ubuntu@<EC2-IP>:/usr/share/nginx/html/
```

Nginx is restarted after deployment:

```bash
ssh -i KUBE-INFRA-KP.pem ubuntu@<EC2-IP> \
'sudo systemctl restart nginx'
```

Replace `<EC2-IP>` with the appropriate private or public IP address, depending on the network configuration.

## Security Considerations

* Never commit `.pem` private keys or AWS credentials to GitHub.
* Store deployment credentials securely in Jenkins Credentials.
* Use IAM roles and least-privilege permissions for AWS access.
* Store passwords using a secure password-hashing algorithm rather than plain text.
* Configure SSH host-key verification instead of disabling it.
* Use HTTPS and appropriate network security-group rules.
* Configure the Nginx reverse proxy correctly to connect the frontend to FastAPI.

## Future Improvements

* Implement automated testing in the Jenkins pipeline.
* Add build notifications and deployment status reporting.
* Introduce secure password hashing and session-based authentication.
* Configure HTTPS using SSL/TLS.
* Use environment variables for application configuration.
* Improve monitoring and application logging.
* Automate infrastructure provisioning using Terraform.

## Disclaimer

This project is intended for learning and demonstrating CI/CD automation, AWS deployment, and web application integration. Additional security controls are required before production use.
