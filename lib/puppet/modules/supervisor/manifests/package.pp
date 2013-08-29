class supervisor::package {

	package { 'supervisor':
		ensure => installed,
		notify => Service['supervisor'];
	}

}
