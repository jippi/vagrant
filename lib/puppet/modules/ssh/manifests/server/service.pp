class ssh::server::service {

	service { 'ssh':
		ensure 	=> running,
		require => Package['openssh-server']
	}

}
