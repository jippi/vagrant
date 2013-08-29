# == Class: essentials::packages
#
# Everything all base systems need
#
# This includes utilities and system packages
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
#  include essentials::packages
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class essentials::packages {

  $packages = [
    'curl',
    'lynx',
    'htop',
    'iotop',
    'locate',
    'pwgen',
    'screen',
    'wget',
    'tzdata',
    'sysstat',
    'iftop',
    'emacs23-nox',
    'php-elisp',
    'gettext',
    'tree',
    'apt-listchanges',
    'rubygems',
    'perl',
    'locales',
    'ftp',
    'ncftp',
    'git-core',
    'subversion',
    'ruby1.9.1-dev',
    'libshadow-ruby1.8',
    'build-essential',
    'bash-completion',
    'python-pygments',
    'chkconfig',
    'strace'
  ]

  $vim_packages = [
    'vim',
    'vim-common',
    'vim-tiny'
  ]

  package {
    $packages:
      ensure => installed;

    $vim_packages:
      ensure => latest;

    'ruby-shadow':
      ensure    => installed,
      provider  => gem,
      require   => Package['build-essential'];
  }

}
