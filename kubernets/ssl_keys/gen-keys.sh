#!/usr/bin/env bash

# generate CA
openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

# generate api server keys
openssl genrsa -out apiserver-key.pem 2048
openssl req -new -key apiserver-key.pem -out apiserver.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf

# generate worker keys
WORKER_FQDN1=kube-worker1
WORKER_FQDN2=kube-worker2
WORKER_IP1=10.132.0.3
WORKER_IP2=10.132.0.4

openssl genrsa -out ${WORKER_FQDN1}-worker-key.pem 2048
WORKER_IP=${WORKER_IP1} openssl req -new -key ${WORKER_FQDN1}-worker-key.pem -out ${WORKER_FQDN1}-worker.csr -subj "/CN=${WORKER_FQDN1}" -config worker-openssl.cnf
WORKER_IP=${WORKER_IP1} openssl x509 -req -in ${WORKER_FQDN1}-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out ${WORKER_FQDN1}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

openssl genrsa -out ${WORKER_FQDN2}-worker-key.pem 2048
WORKER_IP=${WORKER_IP2} openssl req -new -key ${WORKER_FQDN2}-worker-key.pem -out ${WORKER_FQDN2}-worker.csr -subj "/CN=${WORKER_FQDN2}" -config worker-openssl.cnf
WORKER_IP=${WORKER_IP2} openssl x509 -req -in ${WORKER_FQDN2}-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out ${WORKER_FQDN2}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# cluster admin keys
openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365