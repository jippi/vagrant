# == Class: mysql
#
# mysql base class
#
# Doesn't really do anything at this point in time
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
#  include mysql
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class mysql_support {

  Class['mysql']          -> Mysql_support::Db_with_user_and_grant <| |>
  Class['mysql::server']  -> Mysql_support::Db_with_user_and_grant <| |>

  Mysql_database  { defaults => '/etc/mysql/debian.cnf' }
  Mysql_user      { defaults => '/etc/mysql/debian.cnf' }
  Mysql_grant     { defaults => '/etc/mysql/debian.cnf' }

}
