class redis($version = installed) {

	class { 'redis::package':
		version => $version;
	}

	include redis::service
	include redis::files

}
