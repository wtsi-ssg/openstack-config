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


# following http://www.sebastien-han.fr/blog/2014/09/01/openstack-use-ephemeral-and-persistent-root-storage-for-different-hypervisors/
# to have separate hypervisors for Ceph-backed and ephemeral-backed (local) root disk
nova aggregate-create ephemeral-compute-storage
nova aggregate-create ceph-compute-storage

nova aggregate-set-metadata ephemeral-compute-storage ephemeralcomputestorage=true
nova aggregate-set-metadata ceph-compute-storage cephcomputestorage=true

nova aggregate-add-host ephemeral-compute-storage overcloud-compute-1.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-0.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-2.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-3.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-4.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-5.localdomain
nova aggregate-add-host ceph-compute-storage overcloud-compute-6.localdomain

# we try to follow Amazon's naming scheme
# https://aws.amazon.com/ec2/instance-types/

for i in m1.tiny m1.small m1.xlarge m1.medium m1.large ; do
    nova flavor-key $i set aggregate_instance_extra_specs:cephcomputestorage=true
done

# global flavors are numbered 1000+
nova flavor-create c1.large   1000 4096  8 2
nova flavor-create c1.xlarge  1001 8192  8 4
nova flavor-create c1.2xlarge 1002 16384 8 8
for i in c1.large c1.xlarge c1.2xlarge ; do
    nova flavor-key $i set aggregate_instance_extra_specs:cephcomputestorage=true
done

# project-specific flavors are numbered 2000+
# disk-heavy flavo(u)rs for kr2: 32GB RAM, 400GB root disk
nova flavor-create d1.2xlarge 2000 32768 400 8
nova flavor-key d1.2xlarge set aggregate_instance_extra_specs:ephemeralcomputestorage=true
nova flavor-create d1.4xlarge 2001 32768 400 16
nova flavor-key d1.4xlarge set aggregate_instance_extra_specs:ephemeralcomputestorage=true
