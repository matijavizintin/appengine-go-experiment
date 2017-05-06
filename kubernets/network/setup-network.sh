#!/usr/bin/env bash

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/flannel'
scp options.env ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv options.env /etc/flannel/'
ssh ${MASTER_HOST} 'sudo sed -i -e s/ADVERTISE_IP/${COREOS_PRIVATE_IPV4}/g /etc/flannel/options.env'
ssh ${MASTER_HOST} 'sudo sed -i -e s/FLANNELD_ETCD_ENDPOINTS=ETCD_ENDPOINTS/FLANNELD_ETCD_ENDPOINTS=${ETCD_ENDPOINTS}/g /etc/flannel/options.env'

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/systemd/system/flanneld.service.d'
scp 40-ExecStartPre-symlink.conf ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv 40-ExecStartPre-symlink.conf /etc/systemd/system/flanneld.service.d/'