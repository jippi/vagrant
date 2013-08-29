# == Class: essentials::files
#
# Essentials files
#
#  - Change timezone to UTC
#  - Change /etc/environment
#  - Change /etc/resolv.conf
#  - Change /etc/hosts
#  - Change /etc/gitconfig
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include essentials::files
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class essentials::files {

  file {
    '/etc/bownty':
      ensure  => directory,
      force   => true,
      owner   => root,
      group   => root,
      mode    => '0644';

    '/etc/timezone':
      content => 'UTC';

    '/etc/environment':
      source  => 'puppet:///modules/essentials/etc/environment',
      owner   => root,
      group   => root,
      force   => true;

    '/etc/localtime':
        ensure  => file,
        force   => true,
        source  => '/usr/share/zoneinfo/UTC';

    '/etc/gitconfig':
      ensure  => file,
      force   => true,
      source  => 'puppet:///modules/essentials/etc/gitconfig';

    '/opt':
      ensure => directory;

    '/usr/local/bin/':
      ensure  => directory,
      mode    => '0555',
      recurse => true,
      force   => true,
      owner   => root,
      group   => root;
  }

}
