# == Class: elasticsearch
#
# Elastic main class
#
# Enables the following classes automatically:
#  - elasticsearch::apt
#  - elasticsearch::package
#  - elasticsearch::service
#
# You still need to call elasticsearch::config by hand
# to setup your cluster
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
#  include elasticsearch
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class elasticsearch($version) {

	class { 'elasticsearch::apt':
    version => $version
  }

  class { 'elasticsearch::package':
    version => $version
  }

	include elasticsearch::service

}
