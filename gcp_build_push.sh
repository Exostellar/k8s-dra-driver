#!/bin/bash

#gcloud auth configure-docker us-central1-docker.pkg.dev

make build-image
make docker-generate
make -f deployments/container/Makefile build

docker tag nvcr.io/nvidia/cloud-native/k8s-dra-driver:v0.1.0 us-central1-docker.pkg.dev/poc-omniops-gpu/sdg/nvidia-dra:latest
docker push us-central1-docker.pkg.dev/poc-omniops-gpu/sdg/nvidia-dra:latest

# restart pods
sleep 2
kubectl delete pods -n nvidia -l app.kubernetes.io/instance=nvidia-dra-driver
