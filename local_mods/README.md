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

This Ansible playbook applies Sanger local customizations to a
deployed OpenStack overcloud.

## Running the playbook

```
$ ansible-playbook local_mods.yaml 
```

## Assumptions:

* you have the heat-admin user's ssh key in ~/.ssh/stack-set1-id_rsa

## TODO:

* make inventory dynamic, possibly using https://github.com/ansible/ansible/blob/devel/contrib/inventory/openstack.py
