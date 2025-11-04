chmod 400 KUBE-INFRA-KP.pem
mkdir -p ~/.ssh
echo "Host *\n\tStrictHostKeyChecking no\n\tUserKnownHostsFile=/dev/null\n" > ~/.ssh/config
chmod 600 ~/.ssh/config
scp -i KUBE-INFRA-KP.pem web/* ubuntu@172.31.14.22:/usr/share/nginx/html/
ssh -i KUBE-INFRA-KP.pem ubuntu@172.31.14.22 'sudo systemctl restart nginx'
