class nginx::no_default_site {

  file { '/etc/nginx/sites-enabled/default':
    ensure => absent,
    notify => Service['nginx'];
  }

}
