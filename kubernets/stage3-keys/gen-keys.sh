#!/usr/bin/env bash

mkdir certs

# generate CA
openssl genrsa -out certs/ca-key.pem 2048
openssl req -x509 -new -nodes -key certs/ca-key.pem -days 10000 -out certs/ca.pem -subj "/CN=kube-ca"

# generate api server keys
openssl genrsa -out certs/apiserver-key.pem 2048
openssl req -new -key certs/apiserver-key.pem -out certs/apiserver.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in certs/apiserver.csr -CA certs/ca.pem -CAkey certs/ca-key.pem -CAcreateserial -out certs/apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf

# generate worker keys
openssl genrsa -out certs/${WORKER1_FQDN}-worker-key.pem 2048
WORKER_IP=${WORKER1_IP} openssl req -new -key certs/${WORKER1_FQDN}-worker-key.pem -out certs/${WORKER1_FQDN}-worker.csr -subj "/CN=${WORKER1_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER1_IP} openssl x509 -req -in certs/${WORKER1_FQDN}-worker.csr -CA certs/ca.pem -CAkey certs/ca-key.pem -CAcreateserial -out certs/${WORKER1_FQDN}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

openssl genrsa -out certs/${WORKER2_FQDN}-worker-key.pem 2048
WORKER_IP=${WORKER2_IP} openssl req -new -key certs/${WORKER2_FQDN}-worker-key.pem -out certs/${WORKER2_FQDN}-worker.csr -subj "/CN=${WORKER2_FQDN}" -config worker-openssl.cnf
WORKER_IP=${WORKER2_IP} openssl x509 -req -in certs/${WORKER2_FQDN}-worker.csr -CA certs/ca.pem -CAkey certs/ca-key.pem -CAcreateserial -out certs/${WORKER2_FQDN}-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf

# cluster admin keys
openssl genrsa -out certs/admin-key.pem 2048
openssl req -new -key certs/admin-key.pem -out certs/admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in certs/admin.csr -CA certs/ca.pem -CAkey certs/ca-key.pem -CAcreateserial -out certs/admin.pem -days 365