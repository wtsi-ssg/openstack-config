#!/bin/bash

# we try to follow Amazon's naming scheme
# https://aws.amazon.com/ec2/instance-types/

nova flavor-create c1.large   1000 4096  8 2
nova flavor-create c1.xlarge  1001 8192  8 4
nova flavor-create c1.2xlarge 1002 16384 8 8
