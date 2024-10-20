# cluster-configs
K8S cluster configurations


# Health Check
Kubelet `sudo journalctl -u kubelet` or 
```bash
curl http://localhost:10248/healthz
```
Api Server `??` or
```bash
kubectl get componentstatuses
kubectl get nodes
kubectl get pods --all-namespaces
```

