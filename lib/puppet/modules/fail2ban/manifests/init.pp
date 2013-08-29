# == Class: fail2ban
#
# fail2ban base class
#
# Automatically includes the following classes
#  - fail2ban::package
#  - fail2ban::service
#
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
#  include fail2ban
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class fail2ban {

  include fail2ban::package
  include fail2ban::service

}
