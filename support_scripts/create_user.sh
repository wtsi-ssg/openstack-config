#!/bin/bash
# this expects that the tenant has already been created

if [ "$OS_AUTH_URL" = "" ]; then
  echo "OS_AUTH_URL not set (load an rc file)"
  exit 1
fi

if [ "$USERACCOUNT" = "" ]; then
  echo specify USERACCOUNT
  exit 2
fi

if [ "$TENANT" = "" ]; then
  echo specify TENANT
  exit 3
fi

if [ "$ENABLED" = "" ]; then
  ENABLED="true"
fi

if [ "$NEWPASSWORD" = "" ]; then
    NEWPASSWORD="`pwgen -B -1`"
fi
if [ "$NEWPASSWORD" = "" ]; then
  echo "No password set"
  exit 4 ;
fi

if [ "$EMAIL" = "" ]; then
    EMAIL="${USERACCOUNT}@sanger.ac.uk"
fi

keystone user-create --name "$USERACCOUNT" --tenant "$TENANT" \
        --pass "$NEWPASSWORD" --email "$EMAIL" --enabled "$ENABLED"

mailx -s "OpenStack beta account creation" $EMAIL << EOT
Hello ${USERACCOUNT},

An account has been created for you on the beta OpenStack system.

You can log in at http://openstack-beta.internal.sanger.ac.uk/
with the username $USERACCOUNT and password $NEWPASSWORD

Please note that as a proof-of-concept system, this should be
considered in "permanently vulnerable" status, and is not backed up.

Send questions/comments/abuse to: ssg-isg@sanger.ac.uk
EOT
