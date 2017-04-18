#!/bin/bash

#
# start.bash
#

HAPROXY="/etc/haproxy"
OVERRIDE="/haproxy-override"
PIDFILE="/var/run/haproxy.pid"

CONFIG="haproxy.cfg"
ERRORS="errors"

cd "$HAPROXY"

# Symlink errors directory
if [[ -d "$OVERRIDE/$ERRORS" ]]; then
  mkdir -p "$OVERRIDE/$ERRORS"
  rm -fr "$ERRORS"
  ln -s "$OVERRIDE/$ERRORS" "$ERRORS"
fi

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

# Set backend IP address to machine's private IP address
PRIVATE_IPV4=$(curl --header "Metadata-Flavor:Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip")
sed -i -e "s/server apache private_ipv4:80 check/server apache ${PRIVATE_IPV4}:80 check/g" $HAPROXY/$CONFIG

exec haproxy -f /etc/haproxy/haproxy.cfg -p "$PIDFILE"