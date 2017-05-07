#!/usr/bin/env bash

# setup proxy pod
cp kube-proxy.yaml kube-proxy.yaml.copy

sed -i -e "s|MASTER_HOST|${MASTER_HOST}|g" kube-proxy.yaml.copy

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    ssh ${host} 'sudo mkdir -p /etc/kubernetes/manifests'
    scp kube-proxy.yaml.copy ${host}:kube-proxy.yaml
    ssh ${host} 'sudo mv kube-proxy.yaml /etc/kubernetes/manifests/kube-proxy.yaml'
done

rm kube-proxy.yaml.copy
