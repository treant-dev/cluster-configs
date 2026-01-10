# cluster-configs

## Nodes

`oak` - master
`peach` - MetalLB, network
`cherry` - workers

## Terraform   
```
terraform init
terraform apply
terraform output
terraform destroy
```

## Run k8s init & join workers
1. take ip's from `terraform output`
2. go to `master`
3. run init command, `192.168.0.0/16` there is default calico subnet
```bash
NODE_IP=$(curl -4 ifconfig.me)
sudo kubeadm init \
  --apiserver-advertise-address=$NODE_IP \
  --pod-network-cidr=192.168.0.0/16
```
4. copy to home admin.conf to home dir
```bash
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
5. copy admin.conf to your computer
```bash
scp root@91.99.163.151:/etc/kubernetes/admin.conf ~/.kube/hetzner
```
6. run join command on workers, if you lost it you can restore with command
```bash
kubeadm token create --print-join-command
```
7. install calico
```bash
sudo kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/refs/tags/v3.28.2/manifests/calico.yaml
```
8. set labels and taints
```bash
kubectl label node cherry-0 node-role.kubernetes.io/worker=""
kubectl label node peach node-role.kubernetes.io/router=""
kubectl taint node peach node-role.kubernetes.io/router=true:NoSchedule 
```
9. go to `peach` folder and install: `ingress-nginx`, `metallb`, `cert-manager`

10. your cluster is ready