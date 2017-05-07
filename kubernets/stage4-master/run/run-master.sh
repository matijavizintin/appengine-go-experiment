#!/usr/bin/env bash

# load changed units
ssh ${MASTER_HOST} 'sudo systemctl daemon-reload'

# configure flannel
curl -X PUT -d "value={\"Network\":\"${POD_NETWORK}\",\"Backend\":{\"Type\":\"vxlan\"}}" "http://${ETCD0}:2379/v2/keys/coreos.com/network/config"
ssh ${MASTER_HOST} 'sudo systemctl start flanneld'
ssh ${MASTER_HOST} 'sudo systemctl enable flanneld'

# start kubelet
ssh ${MASTER_HOST} 'sudo systemctl start kubelet'
ssh ${MASTER_HOST} 'sudo systemctl enable kubelet'

# check health
ssh ${MASTER_HOST} 'curl http://127.0.0.1:8080/version'