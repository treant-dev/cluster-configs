# Setup Master Node

```
NODE_IP=$(curl -4 ifconfig.me)
sudo kubeadm init \
  --apiserver-advertise-address=$NODE_IP \
  --pod-network-cidr=10.244.0.0/16
```

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
configuration needed when iptables used. this config not enough, but is better than nothing 
```
# works! 
# sudo vi /etc/kubernetes/manifests/kube-apiserver.yaml
# - --bind-address=$NODE_IP
sudo systemctl daemon-reload
sudo systemctl restart kubelet
```

# Install Calico network plugin
```
sudo kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/refs/tags/v3.28.2/manifests/calico.yaml
```
# Run when worker node is ready
```
kubectl label node spruce node-role.kubernetes.io/worker=""
```

 