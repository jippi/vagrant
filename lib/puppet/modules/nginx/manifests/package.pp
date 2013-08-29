class nginx::package($version = 'installed') {

  package { 'nginx-extras':
    ensure  => $version,
    require => Apt::Source['dotdeb_primary']
  }

  Apt::Source['dotdeb_primary'] -> Package['nginx-extras']

}
