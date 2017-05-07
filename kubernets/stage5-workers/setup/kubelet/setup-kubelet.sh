#!/usr/bin/env bash

cp kubelet.service kubelet.service.copy
sed -i -e "s|DNS_SERVICE_IP|${DNS_SERVICE_IP}|g" kubelet.service.copy
sed -i -e "s|MASTER_HOST|${MASTER_HOST}|g" kubelet.service.copy

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    scp kubelet.service.copy ${host}:kubelet.service
    ssh ${host} 'sudo mv kubelet.service /etc/systemd/system/kubelet.service'
done

rm kubelet.service.copy