# == Class: elasticsearch::package
#
# Elastic package class
#
# Installs the elasticsearch package
#
# === Parameters
#
# No parameters
#
# === Variables
#
# [*es_version*]
#   The version of ElasticSearch to install
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
class elasticsearch::package($version = 'installed') {

	package { "elasticsearch":
		ensure => $version;
	}

	Essentials::Apt::Localpackage["elasticsearch"]
		~> Exec["apt-update-local-repo"]
		~> Exec["apt_update"]
		-> Package["elasticsearch"]

}
