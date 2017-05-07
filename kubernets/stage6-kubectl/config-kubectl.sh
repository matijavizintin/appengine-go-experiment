#!/usr/bin/env bash

PATH_TO_KEYS=~/.kube/certs/

echo "${MASTER_HOST_PUBLIC_IP}  kubernets" >> /etc/hosts

kubectl config set-cluster default-cluster --server=https://kubernets --certificate-authority=${PATH_TO_KEYS}/ca.pem
kubectl config set-credentials default-admin --certificate-authority=${PATH_TO_KEYS}/ca.pem --client-key=${PATH_TO_KEYS}/admin-key.pem --client-certificate=${PATH_TO_KEYS}/admin.pem
kubectl config set-context default-system --cluster=default-cluster --user=default-admin
kubectl config use-context default-system