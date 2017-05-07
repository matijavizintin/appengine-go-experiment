#!/usr/bin/env bash

# load changed units
ssh ${MASTER_HOST} 'sudo systemctl daemon-reload'

# configure flannel
curl -X PUT -d "value={\"Network\":\"${POD_NETWORK}\",\"Backend\":{\"Type\":\"vxlan\"}}" "http://${ETCD0}:2379/v2/keys/coreos.com/network/config"
sudo systemctl start flanneld
sudo systemctl enable flanneld

# start kubelet
sudo systemctl start kubelet
sudo systemctl enable kubelet

# check health
curl http://127.0.0.1:8080/version