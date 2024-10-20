#!/bin/bash
# Install guide from official documentation
# https://docs.nginx.com/nginx-ingress-controller/installation

NGINX_VERSION="v3.7.0"

# Create `nginx-ingress` NameSpace and Service Account
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/$NGINX_VERSION/deployments/common/ns-and-sa.yaml

# Role-Based Access Control (RBAC) creation
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/$NGINX_VERSION/deployments/rbac/rbac.yaml

# Create Custom Resource Definitions (CRDs)
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/$NGINX_VERSION/deploy/crds.yaml

# Create NodePort Service
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/$NGINX_VERSION/deployments/service/nodeport.yaml

# Change nodePorts to 30080 for & 30443 for https
kubectl patch svc nginx-ingress -n nginx-ingress --type='json' -p="[{'op': 'replace', 'path': '/spec/ports/0/nodePort', 'value': 30080}]"
kubectl patch svc nginx-ingress -n nginx-ingress --type='json' -p="[{'op': 'replace', 'path': '/spec/ports/1/nodePort', 'value': 30443}]"

# Apply Deployment
kubectl apply -f https://raw.githubusercontent.com/nginxinc/kubernetes-ingress/$NGINX_VERSION/deployments/deployment.yaml
