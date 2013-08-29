class roles::php($version = 'installed') {

  include php
  include php::apt
  include php::params
  include php::pear
  include php::composer
  include php::composer::auto_update

  # Extensions must be installed before they are configured
  Php::Extension <| |> -> Php::Config <| |>

  # Ensure base packages is installed in the correct order
  # and before any php extensions
  Package['php5-common'] -> Package['php5-dev'] -> Package['php5-cli'] -> Php::Extension <| |>

  class {
    # Base packages
    [ 'php::dev', 'php::cli' ]:
      ensure => $version;

    # PHP extensions
    [ 'php::extension::curl', 'php::extension::gd', 'php::extension::imagick', 'php::extension::mcrypt', 'php::extension::mysql', 'php::extension::ssh2', 'php::extension::redis' ]:
      ensure => $version;
  }

  # Configure session lifetime
  php::config { 'php5-session.gc_maxlifetime':
    inifile   => '/etc/php5/conf.d/session.ini',
    settings  => {
      set => {
        '.anon/session.gc_maxlifetime' => 86400
      }
    }
  }

  Php::Extension['igbinary'] -> File['/etc/php5/conf.d/igbinary.ini']

  # Install APC user cache only (php 5.5 uses OptCache instead of APC)
  php::extension { 'php5-apcu':
    ensure    => $version,
    package   => 'php5-apcu',
    provider  => 'apt'
  }

  # Install the INTL extension
  php::extension { 'php5-intl':
    ensure    => $version,
    package   => 'php5-intl',
    provider  => 'apt',
  }

  # Install igbinary serializer
  php::extension { 'igbinary':
    ensure    => installed,
    package   => 'igbinary',
    provider  => 'pecl'
  }

  file { '/etc/php5/conf.d/igbinary.ini':
    content => 'extension=igbinary.so'
  }

}
