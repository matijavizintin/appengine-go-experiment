#!/usr/bin/env bash

scp kubelet.service ${MASTER_HOST}:
ssh ${MASTER_HOST} 'sudo mv kubelet.service /etc/systemd/system/kubelet.service'