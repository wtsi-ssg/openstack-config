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
