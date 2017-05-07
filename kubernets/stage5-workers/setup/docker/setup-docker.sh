#!/usr/bin/env bash

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    ssh ${host} 'sudo mkdir -p /etc/systemd/system/docker.service.d'
    scp 40-flannel.conf ${host}:
    ssh ${host} 'sudo mv 40-flannel.conf /etc/systemd/system/docker.service.d/'

    ssh ${host} 'sudo mkdir -p /etc/kubernetes/cni'
    scp docker_opts_cni.env ${host}:
    ssh ${host} 'sudo mv docker_opts_cni.env /etc/kubernetes/cni/'

    ssh ${host} 'sudo mkdir -p /etc/kubernetes/cni/net.d'
    scp 10-flannel.conf ${host}:
    ssh ${host} 'sudo mv 10-flannel.conf /etc/kubernetes/cni/net.d/'
done