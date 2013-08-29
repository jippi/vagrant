class jenkins::nginx {

  file { '/etc/nginx/sites-enabled/jenkins':
    ensure => file,
    source => 'puppet:///modules/jenkins//etc/nginx/sites-enabled/jenkins',
    notify => Service['nginx']
  }

}
