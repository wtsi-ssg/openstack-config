#!/bin/bash
COMPUTESCALE=7
CONTROLSCALE=3
CEPHSCALE=3
if [ "$FLOATVLAN" = "" ]; then
    echo "please set FLOATVLAN to tag number of floating IP network"
    exit 1
fi
cd ~stack
. stackrc
openstack overcloud deploy --templates ~/templates/my-overcloud -e ~/templates/my-overcloud/environments/network-isolation.yaml -e ~/templates/network-environment.yaml -e ~/templates/storage-environment.yaml --control-scale $CONTROLSCALE --compute-scale $COMPUTESCALE --ceph-storage-scale $CEPHSCALE --control-flavor control --compute-flavor compute --ceph-storage-flavor ceph-storage --ntp-server pool.ntp.org --neutron-network-type vxlan --neutron-tunnel-types vxlan --neutron-bridge-mappings datacentre:br-ex,br-eth1:br-eth1 --neutron-network-vlan-ranges datacentre:1:1000,br-eth1:$FLOATVLAN:$FLOATVLAN
