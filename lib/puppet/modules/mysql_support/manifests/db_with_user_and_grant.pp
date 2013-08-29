# == Define: mysql::db_with_user_and_grant
#
# Configure a mysql db with a user account for it
#
# The resource name will be both db user and db name
#
# === Parameters
#
# A list of valid parameters
#
# [*username*]
#   The user username
#
# [*host*]
#   The user hostname
#
# [*password*]
#   The database password
#
# [*database*]
#   The database name
#
# === Examples
#
#  N/A
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
define mysql_support::db_with_user_and_grant(
  $username = "$name",
  $database = "$name",
  $host = '%',
  $password = ''
) {

  database { ["${database}", "${database}_test", "${database}_seed"]:
    ensure  => present,
    require => Class['mysql'];
  }

  database_user { ["${username}@${host}"]:
    ensure        => present,
    password_hash => mysql_password($password),
    require       => Class['mysql'];
  }

  database_grant { ["${username}@${host}/${database}", "${username}@${host}/${database}_test", "${username}@${host}/${database}_seed"]:
    privileges => all,
    require => [
      Database["${database}"],
      Database["${database}_test"],
      Database["${database}_seed"],
      Database_User["${username}@${host}"]
    ]
  }

}
