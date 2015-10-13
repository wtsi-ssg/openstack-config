#!
# TENANT=hgi INSTANCES=64 CORES=96 RAM=65536 FLOATINGIPS=15 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
# TENANT=hgiarvados INSTANCES=64 CORES=96 RAM=65536 FLOATINGIPS=15 VOLUMEGB=100 VOLUMES=10   ./create_tenant_group.sh 
export RAM="4096"
for i in ad7 ch12 cn13 ej4 ic4 jr17 mk18 mp15 
do
  USERACCOUNT="$i" TENANT="$i"           ./create_user_and_tenant.sh
  USERACCOUNT="$i" TENANT="hgi"          ./add_user_to_tenant.sh
  USERACCOUNT="$i" TENANT="hgiarvados"   ./add_user_to_tenant.sh
done

