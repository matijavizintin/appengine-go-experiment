#!/usr/bin/env bash

MASTER_NODE=10.132.0.2

scp ca.pem ${MASTER_NODE}:
scp apiserver.pem ${MASTER_NODE}:
scp apiserver-key.pem ${MASTER_NODE}:

ssh ${MASTER_NODE} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${MASTER_NODE} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${MASTER_NODE} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${MASTER_NODE} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'