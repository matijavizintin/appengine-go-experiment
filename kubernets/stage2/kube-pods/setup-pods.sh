#!/usr/bin/env bash

# setup api server
ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/manifests'
scp kube-apiserver.yaml ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv kube-apiserver.yaml /etc/kubernetes/manifests/kube-apiserver.yaml'
ssh ${MASTER_HOST} 'sudo sed -i -e s/ETCD_ENDPOINTS/${ETCD_ENDPOINTS}/g /etc/kubernetes/manifests/kube-apiserver.yaml'
ssh ${MASTER_HOST} 'sudo sed -i -e s/SERVICE_IP_RANGE/${SERVICE_IP_RANGE}/g /etc/kubernetes/manifests/kube-apiserver.yaml'
ssh ${MASTER_HOST} 'sudo sed -i -e s/ADVERTISE_IP/${COREOS_PRIVATE_IPV4}/g /etc/kubernetes/manifests/kube-apiserver.yaml'