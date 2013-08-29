class development::package::protagonist {

	package { 'protagonist':
		ensure	 => installed,
		provider => npm;
	}

	File['/usr/local/bin/npm'] -> Package['coffee-script']

}
