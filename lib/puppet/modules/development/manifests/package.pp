class development::package {

	package { 'semver':
		ensure => installed,
		provider => gem;
	}

}
