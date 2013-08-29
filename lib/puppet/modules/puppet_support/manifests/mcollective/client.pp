class puppet_support::mcollective::client {

	package { 'mcollective-client':
    ensure => installed
  }

	file {'/etc/mcollective/client.cfg':
  	source 	=> 'puppet:///modules/puppet_support/etc/mcollective/client.cfg',
  	replace	=> true
  }

	exec { 'fix_ruby_version_mcollective_client':
    command => 'sed -i "s/env ruby/env ruby1.8/i" /usr/bin/mco',
    unless  => 'grep "1.8" /usr/bin/mco'
	}

  Package['mcollective-client']
  	-> File['/etc/mcollective/client.cfg']

}
