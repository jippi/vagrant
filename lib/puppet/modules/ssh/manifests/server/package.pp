class ssh::server::package {

	package { 'openssh-server':
		ensure => installed
	}

}
