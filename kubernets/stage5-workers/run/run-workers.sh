#!/usr/bin/env bash

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    # load changed units
    ssh ${host} 'sudo systemctl daemon-reload'

    # start flannel
    ssh ${host} 'sudo systemctl start flanneld'
    ssh ${host} 'sudo systemctl enable flanneld'

    # start kubelet
    ssh ${host} 'sudo systemctl start kubelet'
    ssh ${host} 'sudo systemctl enable kubelet'
done