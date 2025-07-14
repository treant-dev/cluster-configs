helm repo add metallb https://metallb.github.io/metallb

helm install metallb metallb/metallb \
  --namespace metallb-system \
  --create-namespace \
  -f metallb-values.yaml