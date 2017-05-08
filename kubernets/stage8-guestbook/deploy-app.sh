#!/usr/bin/env bash

# deploy redis master
kubectl create -f redis-master-service.yaml
kubectl create -f redis-master-deployment.yaml

# deploy redis slaves
kubectl create -f redis-slave.yaml

# deploy frontend
kubectl create -f frontend.yaml
