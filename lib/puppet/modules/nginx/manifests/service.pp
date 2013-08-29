class nginx::service {

  service { 'nginx':
    ensure  => running,
    require => Class['nginx::package']
  }

}
