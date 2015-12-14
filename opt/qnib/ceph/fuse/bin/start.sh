#!/bin/bash

source /opt/qnib/consul/etc/bash_functions.sh
wait_for_srv ceph-mon

sleep 2
curl -s "localhost:8500/v1/kv/ceph/?keys" |grep ceph.client.admin.keyring >/dev/null
EC=$?
while [ ${EC} -ne 0 ];do
    echo "sleep 1"
	sleep 1
    curl -s "localhost:8500/v1/kv/ceph/?keys" |grep ceph.client.admin.keyring >/dev/null
    EC=$?
done

# Create keyring
consul-template -once -template /etc/consul-templates/ceph/ceph.client.admin.keyring.ctmpl:/etc/ceph/ceph.client.admin.keyring
# create conf
consul-template -once -template /etc/consul-templates/ceph/ceph.conf.ctmpl:/etc/ceph/ceph.conf

# create /ceph
mkdir -p /ceph
# start fuse
ceph-fuse -f /ceph

