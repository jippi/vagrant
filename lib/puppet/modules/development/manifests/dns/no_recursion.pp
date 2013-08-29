class development::dns::no_recursion {

	if file_exists('/etc/bownty/config/resolvers.yaml') {
		$dns_resolvers = loadyaml('/etc/bownty/config/resolvers.yaml')
	} else {
		$dns_resolvers = ['192.168.1.1']
	}

	file { '/etc/bind/named.conf.options':
		content => template('development/etc/bind/named.conf.options.erb'),
		owner		=> bind,
		group		=> bind;
	}

	Package['bind9'] -> File['/etc/bind/named.conf.options']

	File['/etc/bind/named.conf.options'] ~> Service['bind9']

}
