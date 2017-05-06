#!/usr/bin/env bash

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/systemd/system/docker.service.d'
scp 40-flannel.conf ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv 40-flannel.conf /etc/systemd/system/docker.service.d/'

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/cni'
scp docker_opts_cni.env ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv docker_opts_cni.env /etc/kubernetes/cni/'

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/cni/net.d'
scp 10-flannel.conf ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv 10-flannel.conf /etc/kubernetes/cni/net.d/'