#!/usr/bin/env bash

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    cp options.env options.env.copy
    sed -i -e "s|ADVERTISE_IP|${host}|g" options.env.copy
    sed -i -e "s|FLANNELD_ETCD_ENDPOINTS=ETCD_ENDPOINTS|FLANNELD_ETCD_ENDPOINTS=${ETCD_ENDPOINTS}|g" options.env.copy

    ssh ${host} 'sudo mkdir -p /etc/flannel'
    scp options.env.copy ${host}:options.env
    ssh ${host} 'sudo mv options.env /etc/flannel/'

    rm options.env.copy

    ssh ${host} 'sudo mkdir -p /etc/systemd/system/flanneld.service.d'
    scp 40-ExecStartPre-symlink.conf ${host}:
    ssh ${host} 'sudo mv 40-ExecStartPre-symlink.conf /etc/systemd/system/flanneld.service.d/'
done
