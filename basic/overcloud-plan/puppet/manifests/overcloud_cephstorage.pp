# Copyright 2015 Red Hat, Inc.
# All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

if !str2bool(hiera('enable_package_install', 'false')) {
  case $::osfamily {
    'RedHat': {
      Package { provider => 'norpm' } # provided by tripleo-puppet
    }
    default: {
      warning('enable_package_install option not supported.')
    }
  }
}

create_resources(sysctl::value, hiera('sysctl_settings'), {})

if count(hiera('ntp::servers')) > 0 {
  include ::ntp
}

if str2bool(hiera('ceph_osd_selinux_permissive', true)) {
  exec { 'set selinux to permissive on boot':
    command => "sed -ie 's/^SELINUX=.*/SELINUX=permissive/' /etc/selinux/config",
    onlyif  => "test -f /etc/selinux/config && ! grep '^SELINUX=permissive' /etc/selinux/config",
    path    => ["/usr/bin", "/usr/sbin"],
  }

  exec { 'set selinux to permissive':
    command => "setenforce 0",
    onlyif  => "which setenforce && getenforce | grep -i 'enforcing'",
    path    => ["/usr/bin", "/usr/sbin"],
  } -> Class['ceph::profile::osd']
}

include ::ceph::profile::client
include ::ceph::profile::osd