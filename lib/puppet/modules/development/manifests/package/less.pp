class development::package::less {

	package { 'less':
		ensure 	 => installed,
		provider => npm;
	}

	File['/usr/local/bin/npm'] -> Package['less']

}
