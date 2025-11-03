chmod 400 KUBE-INFRA-KP.pem
scp -i KUBE-INFRA-KP.pem web/* ubuntu@3.110.218.125:/usr/share/nginx/html
ssh -i KUBE-INFRA-KP.pem ubuntu@3.110.218.125 'sudo systemctl restart nginx'