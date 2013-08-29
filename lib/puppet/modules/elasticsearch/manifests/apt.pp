# == Class: elasticsearch::apt
#
# Elastic Search APT configuration
#
# Downloads ElasticSearch to a local DEB repo for easy installation
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
#  include elasticsearch::apt
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class elasticsearch::apt($version) {

	essentials::apt::localpackage {	"elasticsearch":
			url => "http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb";
	}

	Essentials::Apt::Localpackage['elasticsearch'] ~> Exec["apt_update"]

}
