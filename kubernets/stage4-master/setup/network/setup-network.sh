#!/usr/bin/env bash

cp options.env options.env.copy
sed -i -e "s|ADVERTISE_IP|${MASTER_HOST}|g" options.env.copy
sed -i -e "s|FLANNELD_ETCD_ENDPOINTS=ETCD_ENDPOINTS|FLANNELD_ETCD_ENDPOINTS=${ETCD_ENDPOINTS}|g" options.env.copy

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/flannel'
scp options.env.copy ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv options.env /etc/flannel/'

rm options.env.copy

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/systemd/system/flanneld.service.d'
scp 40-ExecStartPre-symlink.conf ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv 40-ExecStartPre-symlink.conf /etc/systemd/system/flanneld.service.d/'