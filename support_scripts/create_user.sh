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
