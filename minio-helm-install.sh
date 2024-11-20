## delete it, use variables from CI
export MINIO_ROOT_USER=secretUser
export MINIO_ROOT_PASSWORD=secretPass

NAMESPACE=minio-helm

helm upgrade --install minio minio \
--namespace ${NAMESPACE} \
--set  secrets.minio.user=${MINIO_ROOT_USER} \
--set  secrets.minio.password=${MINIO_ROOT_PASSWORD} \
--dry-run
