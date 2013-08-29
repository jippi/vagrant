class puppet_support::package($version = 'installed') {

	package { ['puppet-common', 'puppetmaster-common']:
		ensure => $version;
	}

	Package['puppet-common'] -> Package['puppetmaster-common'] -> Package['puppetmaster'] -> Package['puppet-dashboard']

}
