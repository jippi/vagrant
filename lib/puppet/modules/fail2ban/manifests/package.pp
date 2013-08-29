# == Class: fail2ban::package
#
# fail2ban package class
#
# Installs fail2ban on the server
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
#  include fail2ban::package
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class fail2ban::package {

  package { 'fail2ban':
    ensure  => 'installed',
    notify  => Service[fail2ban];
  }

}
