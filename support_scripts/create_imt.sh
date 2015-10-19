#!/bin/bash
TENANT=ssg-imt INSTANCES=64 CORES=96 RAM=65536 FLOATINGIPS=15 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
for i in jg9
do
  USERACCOUNT="$i" TENANT="$i"           ./create_user_and_tenant.sh
  USERACCOUNT="$i" TENANT="ssg-imt"      ./add_user_to_tenant.sh
  USERACCOUNT="$i" TENANT="ssg"          ./add_user_to_tenant.sh
done

