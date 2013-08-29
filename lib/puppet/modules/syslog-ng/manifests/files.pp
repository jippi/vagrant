class syslog-ng::files {

  file { '/etc/syslog-ng/conf/':
		ensure	=> 'directory',
		require	=> Package['syslog-ng'];
  }

}
