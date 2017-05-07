#!/usr/bin/env bash

export ETCD0=10.132.0.2
export ETCD1=10.132.0.3
export ETCD2=10.132.0.4

export ETCD_ENDPOINTS=http://${ETCD0}:2379,http://${ETCD1}:2379,http://${ETCD2}:2379

export K8S_SERVICE_IP=10.3.0.1
export SERVICE_IP_RANGE=10.3.0.0/24
export DNS_SERVICE_IP=10.3.0.10
export POD_NETWORK=10.2.0.0/16

export MASTER_HOST=10.132.0.2
export MASTER_HOST_PUBLIC_IP=unset
export WORKER1_IP=10.132.0.3
export WORKER2_IP=10.132.0.4

export WORKER1_FQDN=kube-worker1
export WORKER2_FQDN=kube-worker2
