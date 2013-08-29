define syslog::filemon($file_name, $polling_interval = 10, $file_facility, $file_severity = 'notice') {

	file { "/etc/syslog-ng/conf/${name}.conf":
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		content => template('etc/syslog-ng/conf/conffile.erb'),
		require => Package['syslog-ng'],
		notify  => Service['syslog-ng'],
	}

}
