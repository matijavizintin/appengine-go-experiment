#!/usr/bin/env bash

cp kubelet.service kubelet.service.copy
sed -i -e "s/DNS_SERVICE_IP/${DNS_SERVICE_IP}/g" kubelet.service.copy

scp kubelet.service.copy ${MASTER_HOST}:kubelet.service
ssh ${MASTER_HOST} 'sudo mv kubelet.service /etc/systemd/system/kubelet.service'

rm kubelet.service.copy