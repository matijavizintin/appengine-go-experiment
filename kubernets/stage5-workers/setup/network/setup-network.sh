#!/usr/bin/env bash

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    ssh ${host} 'sudo mkdir -p /etc/flannel'
    scp options.env ${host}:
    ssh ${host} 'sudo mv options.env /etc/flannel/'
    ssh ${host} 'sudo sed -i -e s/ADVERTISE_IP/${COREOS_PRIVATE_IPV4}/g /etc/flannel/options.env'
    ssh ${host} 'sudo sed -i -e s/FLANNELD_ETCD_ENDPOINTS=ETCD_ENDPOINTS/FLANNELD_ETCD_ENDPOINTS=${ETCD_ENDPOINTS}/g /etc/flannel/options.env'

    ssh ${host} 'sudo mkdir -p /etc/systemd/system/flanneld.service.d'
    scp 40-ExecStartPre-symlink.conf ${host}:
    ssh ${host} 'sudo mv 40-ExecStartPre-symlink.conf /etc/systemd/system/flanneld.service.d/'
done