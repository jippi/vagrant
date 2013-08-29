# == Class: essentials::apt
#
# Essentials apt configuration
#
# Loads debian backports apt repository
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
#  include essentials::apt
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class essentials::apt {

  file {
    '/var/cache/local-repo':
      ensure => directory,
      mode   => '0755',
      notify => [
        Exec['apt-update-local-repo'],
        Exec['apt_update']
      ];

    '/etc/apt/sources.list.d/local.list':
      content => 'deb [trusted=yes] file:/var/cache/local-repo /',
      require => [
        File['/var/cache/local-repo']
      ],
      notify  => [
        Exec['apt-update-local-repo'],
        Exec['apt_update']
      ];
  }

  exec { 'apt-update-local-repo':
    cwd         => '/var/cache/local-repo',
    command     => '/usr/bin/apt-ftparchive packages . > Packages',
    refreshonly => true;
  }

  exec { 'aptitude update':
    schedule => daily
  }

  Exec['apt-update-local-repo'] -> Exec <| title=='apt_update' |>

}
