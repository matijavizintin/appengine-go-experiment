#!/usr/bin/env bash

cp etcdcnt.service etcdcnt.service.copy
sed -i -e "s|ETCD0_IP|${ETCD0}|g" etcdcnt.service.copy
sed -i -e "s|ETCD1_IP|${ETCD1}|g" etcdcnt.service.copy
sed -i -e "s|ETCD2_IP|${ETCD2}|g" etcdcnt.service.copy
sed -i -e "s|ETCD_NAME|etcd0|g" etcdcnt.service.copy

scp etcdcnt.service.copy ${MASTER_HOST}:etcdcnt.service
ssh ${MASTER_HOST} 'sudo mv etcdcnt.service /etc/systemd/system/etcdcnt.service'

rm etcdcnt.service.copy

cp etcdcnt.service etcdcnt.service.copy
sed -i -e "s|ETCD0_IP|${ETCD0}|g" etcdcnt.service.copy
sed -i -e "s|ETCD1_IP|${ETCD1}|g" etcdcnt.service.copy
sed -i -e "s|ETCD2_IP|${ETCD2}|g" etcdcnt.service.copy
sed -i -e "s|ETCD_NAME|etcd1|g" etcdcnt.service.copy

scp etcdcnt.service.copy ${WORKER1_IP}:etcdcnt.service
ssh ${WORKER1_IP} 'sudo mv etcdcnt.service /etc/systemd/system/etcdcnt.service'

rm etcdcnt.service.copy

cp etcdcnt.service etcdcnt.service.copy
sed -i -e "s|ETCD0_IP|${ETCD0}|g" etcdcnt.service.copy
sed -i -e "s|ETCD1_IP|${ETCD1}|g" etcdcnt.service.copy
sed -i -e "s|ETCD2_IP|${ETCD2}|g" etcdcnt.service.copy
sed -i -e "s|ETCD_NAME|etcd2|g" etcdcnt.service.copy

scp etcdcnt.service.copy ${WORKER2_IP}:etcdcnt.service
ssh ${WORKER2_IP} 'sudo mv etcdcnt.service /etc/systemd/system/etcdcnt.service'

rm etcdcnt.service.copy