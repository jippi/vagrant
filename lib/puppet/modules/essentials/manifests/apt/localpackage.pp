# == Class: essentials::apt::localpackage
#
# Essentials apt localpackage
#
# Allow local deb files to be part of normal apt repo
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
#  include essentials::apt::localpackage
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
define essentials::apt::localpackage($url = "", $repodir = "/var/cache/local-repo") {

    $url_tokens = split($url, '/')
    $pkg_filename = $url_tokens[-1]

    exec { "apt-localpackage-${name}":
        command  => "/usr/bin/curl -L -s -C - -O $url",
        cwd		 => $repodir,
        creates  => "${repodir}/${pkg_filename}";
    }

    File[$repodir]
        -> Exec["apt-localpackage-${name}"]
        ~> Exec["apt-update-local-repo"]
        ~> Exec["apt_update"]

}
