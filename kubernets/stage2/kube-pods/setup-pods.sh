#!/usr/bin/env bash

# setup api server
cp kube-apiserver.yaml kube-apiserver.yaml.copy
sed -i -e s/ETCD_ENDPOINTS/${ETCD_ENDPOINTS}/g kube-apiserver.yaml.copy
sed -i -e s/SERVICE_IP_RANGE/${SERVICE_IP_RANGE}/g kube-apiserver.yaml.copy

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/manifests'
scp kube-apiserver.yaml.copy ${MASTER_HOST}:kube-apiserver.yaml
ssh ${MASTER_HOST} 'sudo mv kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml'

rm kube-apiserver.yaml.copy
