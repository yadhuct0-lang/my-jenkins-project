chmod 400 KUBE-INFRA-KP.pem
scp -i KUBE-INFRA-KP.pem web/* ubuntu@172.31.14.22:/usr/share/nginx/html
ssh -i KUBE-INFRA-KP.pem ubuntu@172.31.14.22 'sudo systemctl restart nginx'
