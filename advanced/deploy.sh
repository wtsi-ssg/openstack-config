#!/bin/bash
#License
#=======
#  Copyright (c) 2015 Genome Research Ltd. 
#
#  Author: James Beal <James.Beal@sanger.ac.uk>, Dave Holland <dh3@sanger.ac.uk>
#
#  This file is part of  https://github.com/wtsi-ssg/openstack-config
#
#  This  is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  (at your option) any later version.   This program is distributed
#  in the hope that it will be useful, but WITHOUT ANY WARRANTY; 
#  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
#  PARTICULAR PURPOSE. See the GNU General Public License for more details. 
#  You should have received a copy of the GNU General Public License along
#  with this program. If not, see <http://www.gnu.org/licenses/>. 
#
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
