class varnish::package {

  package { 'varnish':
    ensure => $varnish_version,
    require => [
      Class['varnish::apt']
    ];
  }

}
