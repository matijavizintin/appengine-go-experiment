#!/usr/bin/env bash

ssh ${MASTER_HOST} 'sudo systemctl daemon-reload'
ssh ${MASTER_HOST} 'sudo systemctl stop etcdcnt.service'
ssh ${MASTER_HOST} 'sudo systemctl start etcdcnt.service'
ssh ${MASTER_HOST} 'sudo systemctl enable etcdcnt.service'

ssh ${WORKER1_IP} 'sudo systemctl daemon-reload'
ssh ${WORKER1_IP} 'sudo systemctl stop etcdcnt.service'
ssh ${WORKER1_IP} 'sudo systemctl start etcdcnt.service'
ssh ${WORKER1_IP} 'sudo systemctl enable etcdcnt.service'

ssh ${WORKER2_IP} 'sudo systemctl daemon-reload'
ssh ${WORKER2_IP} 'sudo systemctl stop etcdcnt.service'
ssh ${WORKER2_IP} 'sudo systemctl start etcdcnt.service'
ssh ${WORKER2_IP} 'sudo systemctl enable etcdcnt.service'
