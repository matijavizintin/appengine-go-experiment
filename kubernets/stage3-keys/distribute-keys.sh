#!/usr/bin/env bash

# master node
scp certs/ca.pem ${MASTER_HOST}:
scp certs/apiserver.pem ${MASTER_HOST}:
scp certs/apiserver-key.pem ${MASTER_HOST}:

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${MASTER_HOST} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${MASTER_HOST} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${MASTER_HOST} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'

# worker nodes
scp certs/ca.pem ${WORKER1_IP}:
scp certs/${WORKER1_FQDN}-worker.pem ${WORKER1_IP}:worker.pem
scp certs/${WORKER1_FQDN}-worker-key-key.pem ${WORKER1_IP}:worker-key-key.pem

ssh ${WORKER1_IP} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${WORKER1_IP} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${WORKER1_IP} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${WORKER1_IP} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'

scp certs/ca.pem ${WORKER2_IP}:
scp certs/${WORKER2_FQDN}-worker.pem ${WORKER2_IP}:worker.pem
scp certs/${WORKER2_FQDN}-worker-key-key.pem ${WORKER2_IP}:worker-key-key.pem

ssh ${WORKER2_IP} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${WORKER2_IP} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${WORKER2_IP} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${WORKER2_IP} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'
