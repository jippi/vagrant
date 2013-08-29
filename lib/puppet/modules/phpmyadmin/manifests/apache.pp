class phpmyadmin::apache($version) {

	file { '/etc/apache2/conf.d/phpmyadmin.conf':
		content => template('phpmyadmin/etc/apache2/conf.d/phpmyadmin.conf.erb')
	}

	Package['apache2']
		-> Exec['phpmyadmin_extract']
		-> File['/etc/apache2/conf.d/phpmyadmin.conf']

	File['/etc/apache2/conf.d/phpmyadmin.conf'] ~> Service['apache2']

}
