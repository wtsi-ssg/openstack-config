#!/bin/bash
# create tenant group (project) and set quota
#usage: keystone tenant-create --name <tenant-name>
#                              [--description <tenant-description>]
#                              [--enabled <true|false>]

# set defaults - these are set low with the intention of using them
# for the per-user groups

if [ "$OS_AUTH_URL" = "" ]; then
  echo "OS_AUTH_URL not set (load an rc file)"
  exit 1
fi

if [ "$TENANT" = "" ]; then
  echo specify TENANT
  exit 2
fi

if [ "$ENABLED" = "" ]; then
  ENABLED="true"
fi

if [ "$INSTANCES" = "" ]; then
  INSTANCES="10"
fi

if [ "$CORES" = "" ]; then
  CORES="20"
fi

if [ "$RAM" = "" ]; then
  RAM="4096"
fi

if [ "$FLOATINGIPS" = "" ]; then
  FLOATINGIPS="3"
fi

if [ "$VOLUMEGB" = "" ]; then
  VOLUMEGB="2"
fi

if [ "$VOLUMES" = "" ]; then
  VOLUMES="2"
fi

if [ "$SNAPSHOTS" = "" ]; then
  SNAPSHOTS="2"
fi

keystone tenant-create --name "$TENANT" --description "$DESCRIPTION" \
  --enabled "$ENABLED"

# throw away stderr because of forced DeprecationWarnings :(
TENANTID=`keystone tenant-get "$TENANT" 2>/dev/null | awk '$2 ~/id/ {print $4}'`

if [ "$TENANTID" = "" ]; then
  echo "Tenant $TENANT not created"
  exit 3
fi

# add admin as a member so that CloudForms has visibility
USERACCOUNT=admin ./add_user_to_tenant.sh

nova quota-update --instances "$INSTANCES" --cores "$CORES" --ram "$RAM" \
                         "$TENANTID"

neutron quota-update --tenant_id "$TENANTID" -- --floatingip "$FLOATINGIPS"

cinder quota-update --volumes "$VOLUMES" --snapshots "$SNAPSHOTS" \
                           --gigabytes "$VOLUMEGB" "$TENANTID"

