class development::package::debug_kit {

	$version = "master"

	file {
		"/opt/debug_kit":
			ensure 	=> directory,
			recurse => true;

		"/usr/share/php/plugins/":
			ensure 	=> "directory",
			recurse => true;
	}

	exec {
		"debugkit_download":
			command => "/usr/bin/curl -L -s -C - -O https://github.com/cakephp/debug_kit/archive/$version.tar.gz",
      cwd		 	=> "/opt/debug_kit",
      creates => "/opt/debug_kit/$version.tar.gz";

		"debugkit_extract":
			command => "tar zxf $version.tar.gz",
			cwd		 	=> "/opt/debug_kit",
			creates	=> "/opt/debug_kit/debug_kit-$version";
	}

	file { "/usr/share/php/plugins/DebugKit":
		ensure 	=> link,
		target	=> "/opt/debug_kit/debug_kit-$version",
		force		=> true;
	}

	File['/opt']
		-> File['/opt/debug_kit']
		-> Exec['debugkit_download']
		-> Exec['debugkit_extract']
		-> Class['php::cli']
		-> File['/usr/share/php/plugins/']
		-> File['/usr/share/php/plugins/DebugKit']
		~> Service['nginx']
}
