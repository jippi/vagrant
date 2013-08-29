class development::package::sprockets {

	package { 'sprockets':
		ensure	 => installed,
		provider => gem;
	}

	File['/usr/local/bin/npm'] -> Package['coffee-script']

}
