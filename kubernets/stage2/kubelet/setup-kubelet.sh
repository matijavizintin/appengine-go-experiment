#!/usr/bin/env bash

scp kubelet.service ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv kubelet.service /etc/systemd/system/kubelet.service'
ssh ${MASTER_HOST} 'sudo sed -i -e s/NETWORK_PLUGIN/${NETWORK_PLUGIN}/g /etc/systemd/system/kubelet.service'
ssh ${MASTER_HOST} 'sudo sed -i -e s/DNS_SERVICE_IP/${DNS_SERVICE_IP}/g /etc/systemd/system/kubelet.service'