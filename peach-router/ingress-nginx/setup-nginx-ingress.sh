#!/bin/bash
# Install guide from official documentation
# https://docs.nginx.com/nginx-ingress-controller/installation

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx

helm install ingress-nginx ingress-nginx/ingress-nginx \
  --namespace ingress-nginx \
  --create-namespace \
  --values ingress-nginx-values.yaml