sudo yum install iptables-services
sudo systemctl enable iptables
sudo systemctl start iptables
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 30080 -m comment --comment "Redirect to k8s NodePort"
sudo iptables -t nat -A PREROUTING -p tcp --dport 443 -j REDIRECT --to-port 30443 -m comment --comment "Redirect to k8s NodePort"

# Open other k8s ports
sudo iptables -A INPUT -p tcp --dport 6443 -m comment --comment "Kubernetes API Server" -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 80 -m comment --comment "HTTP" -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -m comment --comment "HTTPS" -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 10250 -m comment --comment "Kubelet API" -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 10251 -m comment --comment "Kubernetes Controller Manager" -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 10252 -m comment --comment "Kubernetes Scheduler" -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 10255 -m comment --comment "Kubelet Monitoring" -j ACCEPT
sudo iptables -A INPUT -p udp --dport 8472 -m comment --comment "Kubernetes Network plugin Flannel (VXLAN)" -j ACCEPT

sudo iptables -A INPUT -p tcp --dport 30000:32767 -m comment --comment "Kubernetes NodePort Services" -j ACCEPT

sudo service iptables save
