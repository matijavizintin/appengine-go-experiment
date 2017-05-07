#!/usr/bin/env bash

for host in ${WORKER1_IP} ${WORKER2_IP}
do
    # load changed units
    ssh ${host} 'sudo systemctl daemon-reload'

    # start flannel
    sudo systemctl start flanneld
    sudo systemctl enable flanneld

    # start kubelet
    sudo systemctl start kubelet
    sudo systemctl enable kubelet
done