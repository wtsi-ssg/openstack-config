#!/bin/bash

# we try to follow Amazon's naming scheme
# https://aws.amazon.com/ec2/instance-types/
# global flavors are numbered 1000+
nova flavor-create c1.large   1000 4096  8 2
nova flavor-create c1.xlarge  1001 8192  8 4
nova flavor-create c1.2xlarge 1002 16384 8 8

# project-specific flavors are numbered 2000+
# disk-heavy flavo(u)rs for kr2: 32GB RAM, 400GB root disk
nova flavor-create d1.2xlarge 2000 32768 400 8
nova flavor-create d1.4xlarge 2001 32768 400 16
