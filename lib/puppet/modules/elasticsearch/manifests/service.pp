# == Class: elasticsearch::service
#
# Elastic Search Service class
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
#  include elasticsearch::service
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class elasticsearch::service {

	service {
		'elasticsearch':
			enable      => true,
			ensure      => running,
			hasrestart  => true,
			hasstatus   => true,
	}

	Package["elasticsearch"] -> Service["elasticsearch"]

}
