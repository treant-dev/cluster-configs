#!/bin/bash
kubectl apply \
-f minio-namespace.yaml \
-f minio-persistant-volume.yaml \
-f minio-deployment.yaml \
-f minio-service.yaml \
-f minio-ingress.yaml