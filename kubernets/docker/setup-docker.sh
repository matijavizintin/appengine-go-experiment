#!/usr/bin/env bash

MASTER_NODE=10.132.0.2

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/systemd/system/docker.service.d'
scp 40-flannel.conf ${MASTER_NODE}:
ssh ${MASTER_NODE} 'sudo mv 40-flannel.conf /etc/systemd/system/docker.service.d/'

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/kubernetes/cni'
scp docker_opts_cni.env ${MASTER_NODE}:
ssh ${MASTER_NODE} 'sudo mv docker_opts_cni.env /etc/kubernetes/cni/'

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/kubernetes/cni/net.d'
scp 10-flannel.conf ${MASTER_NODE}:
ssh ${MASTER_NODE} 'sudo mv 10-flannel.conf /etc/kubernetes/cni/net.d/'

