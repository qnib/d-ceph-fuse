#!/bin/bash

sleep 2
source /opt/qnib/consul/etc/bash_functions.sh

wait_for_srv ceph-mon

# Create keyring
consul-template -once -template /etc/consul-templates/templates/ceph.client.admin.keyring.ctmpl:/etc/ceph/ceph.client.admin.keyring
# create conf
consul-template -once -template /etc/consul-templates/templates/ceph.conf.ctmpl:/etc/ceph/ceph.conf

# create /ceph
mkdir /ceph
# start fuse
ceph-fuse /ceph

