class syslog-ng::package {

  package { 'syslog-ng':
		ensure  => 'installed';
  }

}
