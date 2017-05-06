#!/usr/bin/env bash

MASTER_NODE=10.132.0.2

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/flannel'
scp options.env ${MASTER_NODE}:
ssh ${MASTER_NODE} 'sudo mv options.env /etc/flannel/'
ssh ${MASTER_NODE} 'sudo sed -i -e s/ADVERTISE_IP/${COREOS_PRIVATE_IPV4}/g /etc/flannel/options.env'

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/systemd/system/flanneld.service.d'
scp 40-ExecStartPre-symlink.conf ${MASTER_NODE}:
ssh ${MASTER_NODE} 'sudo mv 40-ExecStartPre-symlink.conf /etc/systemd/system/flanneld.service.d/'