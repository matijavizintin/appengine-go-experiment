#!/usr/bin/env bash

scp ca.pem ${MASTER_HOST}:
scp apiserver.pem ${MASTER_HOST}:
scp apiserver-key.pem ${MASTER_HOST}:

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${MASTER_HOST} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${MASTER_HOST} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${MASTER_HOST} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'