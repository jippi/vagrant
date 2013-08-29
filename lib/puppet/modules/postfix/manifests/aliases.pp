class postfix::aliases($root = 'root') {

  file { '/etc/aliases':
    content => template('postfix/etc/aliases.erb'),
    notify  => [
      Exec['newaliases'],
      Service['postfix']
    ]
  }

  exec { 'newaliases':
    refreshonly => true
  }

}
