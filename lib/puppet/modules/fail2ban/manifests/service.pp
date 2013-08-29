# == Class: fail2ban::service
#
# fail2ban service class
#
# Ensures that the fail2ban service is running
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
#  include fail2ban::service
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class fail2ban::service {

  service { 'fail2ban':
    ensure     => 'running',
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    require    => Package['fail2ban']
  }

}
