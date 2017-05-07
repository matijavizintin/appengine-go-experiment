#!/usr/bin/env bash

NAME=""
case ${COREOS_PRIVATE_IPV4} in
    ${ETCD0})
       NAME="etcd0"
       ;;
    ${ETCD1})
        NAME="etcd1"
        ;;
    ${ETCD2})
        NAME="etcd2"
        ;;
esac

if [ -z "${NAME}" ]; then exit 1; fi

docker stop etcd
docker rm etcd
docker run -d --net=host \
 --volume=/etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt --volume=/var/lib/etcd:/etcd-data \
 --name etcd quay.io/coreos/etcd:v3.1.7 /usr/local/bin/etcd \
 --name ${NAME} \
 --data-dir=/etcd-data \
 --advertise-client-urls http://${COREOS_PRIVATE_IPV4}:2379 \
 --listen-client-urls http://${COREOS_PRIVATE_IPV4}:2379 \
 --initial-advertise-peer-urls http://${COREOS_PRIVATE_IPV4}:2380 \
 --listen-peer-urls http://${COREOS_PRIVATE_IPV4}:2380 \
 --initial-cluster-token etcd-cluster-1 \
 --initial-cluster etcd0=http://${ETCD0}:2380,etcd1=http://${ETCD1}:2380,etcd2=http://${ETCD2}:2380 \
 --initial-cluster-state new