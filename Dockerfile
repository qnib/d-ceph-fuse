FROM qnib/ceph-base

RUN apt-get install -y ceph-fuse

ADD opt/qnib/ceph/fuse/bin/start.sh /opt/qnib/ceph/fuse/bin/
ADD etc/supervisord.d/ceph-fuse.ini /etc/supervisord.d/
ADD etc/consul.d/ceph-fuse.json /etc/consul.d/
