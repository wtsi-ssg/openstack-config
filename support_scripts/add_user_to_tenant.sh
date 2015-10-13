#!/bin/bash
# add a user to a tenant group in the _member_ role

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

keystone user-role-add --user "$USERACCOUNT" --role _member_ \
    --tenant "$TENANT"
