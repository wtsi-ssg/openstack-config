#!/bin/bash
# create user and tenant group

if [ "$OS_AUTH_URL" = "" ]; then
  echo "OS_AUTH_URL not set (load an rc file)"
  exit 1
fi

if [ "$USERACCOUNT" = "" ]; then
  echo specify USERACCOUNT
  exit 1
fi

if [ "$TENANT" = "" ]; then
  echo specify TENANT
  exit 1
fi

./create_tenant_group.sh
./create_user.sh

