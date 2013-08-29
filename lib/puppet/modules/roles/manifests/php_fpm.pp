class roles::php_fpm($version = 'installed') {

  include php
  include php::apt
  include php::params

  class { 'php::fpm':
    ensure => $version
  }

  php::fpm::conf { 'www':
    ensure    => present,
    listen    => '/tmp/php-fpm.sock',
    error_log => true
  }

  Php::Config <| |> ~> Service['php5-fpm']
  Php::Extension <| |> ~> Service['php5-fpm']

}
