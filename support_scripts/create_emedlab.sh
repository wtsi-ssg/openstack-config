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

TENANT=emedlab INSTANCES=0 CORES=0 RAM=0 FLOATINGIPS=0 VOLUMEGB=0 VOLUMES=0   ./create_tenant_group.sh 
TENANT=crick INSTANCES=64 CORES=96 RAM=65536 FLOATINGIPS=15 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
export RAM="4096"
for i in luke.raimbach adam.huffman 
do
  export EMAIL="$i@crick.ac.uk"
  SIMPLE=`echo $i|sed -e 's/\.//g'`
  USERACCOUNT="$SIMPLE" TENANT="$SIMPLE"      ./create_user_and_tenant.sh
  USERACCOUNT="$SIMPLE" TENANT="crick"        ./add_user_to_tenant.sh
  USERACCOUNT="$SIMPLE" TENANT="emedlab"      ./add_user_to_tenant.sh
done

