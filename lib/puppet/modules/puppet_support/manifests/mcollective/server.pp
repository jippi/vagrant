class puppet_support::mcollective::server {

# mcollective server

	package { 'libstomp-ruby':
    ensure => installed
  }

  package { 'mcollective':
    ensure  => installed
  }

  package {'mcollective-facter-facts':
  	ensure	=> installed
 	}

  service {'mcollective':
  	ensure => running;
  }

  file {'/etc/mcollective/server.cfg':
  	source 	=> 'puppet:///modules/puppet_support/etc/mcollective/server.cfg',
  	replace	=> true
  }

  exec {'fix_ruby_version_mcollective_server':
    command => 'sed -i "s/env ruby/env ruby1.8/i" /usr/sbin/mcollectived',
    unless  => 'grep "1.8" /usr/sbin/mcollectived',
    notify  => Service['mcollective']
  }

  Package['libstomp-ruby']
  	-> Package['mcollective']
    -> File['/etc/mcollective/server.cfg']
  	~> Service['mcollective']

}
