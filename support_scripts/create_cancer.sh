#!/bin/bash
TENANT=cancer INSTANCES=0 CORES=0 RAM=0 FLOATINGIPS=0 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
TENANT=cancerit INSTANCES=64 CORES=96 RAM=65536 FLOATINGIPS=15 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
export RAM="4096"
for i in kr2
do
  USERACCOUNT="$i" TENANT="$i"           ./create_user_and_tenant.sh
  USERACCOUNT="$i" TENANT="hgi"          ./add_user_to_tenant.sh
  USERACCOUNT="$i" TENANT="hgiarvados"   ./add_user_to_tenant.sh
done

