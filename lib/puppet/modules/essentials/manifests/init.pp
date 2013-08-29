# == Class: essentials
#
# Essentials base class
#
# Loads the follow essentials classes
#  - essentials::packages
#  - essentials::files
#  - essentials::apt
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
#  include essentials
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class essentials {

  include essentials::packages
  include essentials::files
  include essentials::apt
  include essentials::ssh_users
  include essentials::ssh_keys

  schedule {
    hourly:
      period => hourly,
      repeat => 1;
    daily:
      period  => daily,
      repeat  => 1;
    weekly:
      period  => weekly,
      repeat  => 1;
  }

}
