# == Class: mysql::augeas
#
# mysql augeas class
#
# Ensure that the mysql augeas lense is loaded
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
#  include mysql::augeas
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class mysql_support::augeas {

  file { '/usr/share/augeas/lenses/contrib/mysql.aug':
    ensure => present,
    source => 'puppet:///modules/mysql_support/usr/share/augeas/lenses/contrib/mysql.aug',
  }

}
