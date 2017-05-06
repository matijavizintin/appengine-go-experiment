#!/usr/bin/env bash

# generate CA
openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

# generate api server keys
openssl genrsa -out apiserver-key.pem 2048
openssl req -new -key apiserver-key.pem -out apiserver.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf

# generate worker keys
openssl genrsa -out ${WORKER1_FQDN}-worker-key.pem 2048
WORKER_IP=${WORKER1_IP} openssl req -new -key ${WORKER1_FQDN}-worker-key.pem -out ${WORKER1_FQDN}-worker.csr -subj "/CN=${WORKER1_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER1_IP} openssl x509 -req -in ${WORKER1_FQDN}-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out ${WORKER1_FQDN}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

openssl genrsa -out ${WORKER2_FQDN}-worker-key.pem 2048
WORKER_IP=${WORKER2_IP} openssl req -new -key ${WORKER2_FQDN}-worker-key.pem -out ${WORKER2_FQDN}-worker.csr -subj "/CN=${WORKER2_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER2_IP} openssl x509 -req -in ${WORKER2_FQDN}-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out ${WORKER2_FQDN}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# cluster admin keys
openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365