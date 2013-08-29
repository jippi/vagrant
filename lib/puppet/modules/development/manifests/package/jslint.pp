class development::package::jslint {

	package { 'jslint':
		ensure 	 => installed,
		provider => npm;
	}

	File['/usr/local/bin/npm'] -> Package['jslint']

}
