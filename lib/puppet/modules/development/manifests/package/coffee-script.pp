class development::package::coffee-script {

	package { 'coffee-script':
		ensure	 => installed,
		provider => npm;
	}

	File['/usr/local/bin/npm'] -> Package['coffee-script']

}
