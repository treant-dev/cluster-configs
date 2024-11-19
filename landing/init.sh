kubectl delete configmap landing-nginx-proxy -n default
kubectl create configmap landing-nginx-proxy --from-file=nginx.conf -n default
kubectl apply -f landing-deployment.yaml
kubectl apply -f landing-service.yaml
kubectl apply -f landing-ingress.yaml
