sudo yum install iptables-services
sudo systemctl enable iptables
sudo systemctl start iptables
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30080 -m comment --comment "Redirect to k8s NodePort"
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 30443 -m comment --comment "Redirect to k8s NodePort"
sudo service iptables save