#!/bin/bash
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

