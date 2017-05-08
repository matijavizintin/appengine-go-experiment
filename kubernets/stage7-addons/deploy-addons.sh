#!/usr/bin/env bash

# deploy dns
cp dns-addon.yml dns-addon.yml.copy
sed -i -e "s|DNS_SERVICE_IP|${DNS_SERVICE_IP}|g" dns-addon.yml.copy
kubectl create -f dns-addon.yml.copy
rm dns-addon.yml.copy*

# check dns pod
kubectl get pods --namespace=kube-system | grep kube-dns-v20

# deploy dashboard
kubectl create -f kube-dashboard-rc.yaml
kubectl create -f kube-dashboard-svc.yaml