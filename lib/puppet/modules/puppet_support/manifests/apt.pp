class puppet_support::apt {

	apt::source { 'puppetlabs':
	  location   => 'http://apt.puppetlabs.com',
	  repos      => 'main',
	  key        => '4BD6EC30',
	  key_server => 'pgp.mit.edu',
	}

	apt::pin { 'puppet':
	  origin    => 'apt.puppetlabs.com',
	  order     => 10,
	  priority  => 1500,
	  packages  => 'puppet-dashboard puppet-testsuite puppet-common puppetmaster puppetmaster-common facter',
	  require   => Apt::Source['puppetlabs'];
	}

}
