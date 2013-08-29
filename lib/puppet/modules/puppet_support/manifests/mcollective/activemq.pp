class puppet_support::mcollective::activemq {
  # ActiveMQ

  package {'openjdk-6-jre':
  	ensure => installed
  }

  package {'activemq':
  	ensure => installed;
  }

  service {'activemq':
  	ensure => running;
  }

  file {'/etc/activemq/instances-enabled/main':
  	ensure	=> link,
  	source	=> '/etc/activemq/instances-available/main'
  }

  file {'/etc/activemq/instances-enabled/main/activemq.xml':
  	source 	=> 'puppet:///modules/puppet_support/etc/activemq/instances-enabled/activemq.xml',
  	replace	=> true
  }

  Package['openjdk-6-jre']
  	-> Package['activemq']
  	-> File['/etc/activemq/instances-enabled/main']
  	-> File['/etc/activemq/instances-enabled/main/activemq.xml']
  	~> Service['activemq']

}
