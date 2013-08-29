class postfix::config() {

  file { '/etc/postfix/main.cf':
    ensure  => file,
    content => template('postfix/etc/postfix/main.cf.erb'),
    notify  => Service['postfix']
  }

  file { '/etc/postfix/sasl_passwd':
    ensure  => file,
    content => template('postfix/etc/postfix/sasl_passwd.erb'),
    notify  => Exec['build_sasl_passwd_db']
  }

  exec { 'build_sasl_passwd_db':
    command     => 'postmap hash:/etc/postfix/sasl_passwd',
    refreshonly => true,
    notify      => Service['postfix']
  }

}
