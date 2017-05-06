#!/usr/bin/env bash

HOST0=10.132.0.2
HOST1=10.132.0.3
HOST2=10.132.0.4

PRIVATE_IPV4=$(curl -sw "\n" --header "Metadata-Flavor:Google" "http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip")

NAME=""
case ${PRIVATE_IPV4} in
    ${HOST0})
       NAME="etcd0"
       ;;
    ${HOST1})
        NAME="etcd1"
        ;;
    ${HOST2})
        NAME="etcd2"
        ;;
esac

if [ -z "${NAME}" ]; then exit 1; fi

docker stop etcd
docker rm etcd
docker run -d --net=host --name etcd quay.io/coreos/etcd:v3.1.7 /usr/local/bin/etcd \
 --volume=/etc/ssl/certs/ca-certificates.crt:/etc/ssl/certs/ca-certificates.crt --volume=/var/lib/etcd:/etcd-data \
 --name ${NAME} \
 --data-dir=/etcd-data \
 --advertise-client-urls http://${PRIVATE_IPV4}:2379 \
 --listen-client-urls http://${PRIVATE_IPV4}:2379 \
 --initial-advertise-peer-urls http://${PRIVATE_IPV4}:2380 \
 --listen-peer-urls http://${PRIVATE_IPV4}:2380 \
 --initial-cluster-token etcd-cluster-1 \
 --initial-cluster etcd0=http://${HOST0}:2380,etcd1=http://${HOST1}:2380,etcd2=http://${HOST2}:2380 \
 --initial-cluster-state new