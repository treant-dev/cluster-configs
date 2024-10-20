#!/bin/bash

sudo kubeadm init --config kubeadm-config.yaml

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/refs/tags/v3.28.2/manifests/calico.yaml