#!/usr/bin/env bash

scp certs/ca.pem ${MASTER_HOST}:
scp certs/apiserver.pem ${MASTER_HOST}:
scp certs/apiserver-key.pem ${MASTER_HOST}:

ssh ${MASTER_HOST} 'sudo mkdir -p /etc/kubernetes/ssl'
ssh ${MASTER_HOST} 'sudo mv *.pem /etc/kubernetes/ssl/'
ssh ${MASTER_HOST} 'sudo chmod 600 /etc/kubernetes/ssl/*-key.pem'
ssh ${MASTER_HOST} 'sudo chown root:root /etc/kubernetes/ssl/*-key.pem'