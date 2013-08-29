class supervisor::files {

  file {
    '/etc/init.d/supervisor':
      ensure  => file,
      mode    => '0744',
      source  => 'puppet:///modules/supervisor/etc/init.d/supervisor',
      notify  => Service['supervisor'],
      require => Package['supervisor'];

    '/etc/supervisor/supervisord.conf':
      ensure  => file,
      content => template('supervisor/etc/supervisor/supervisord.conf.erb'),
      notify  => Service['supervisor'],
      require => File['/etc/init.d/supervisor'];
  }

}
