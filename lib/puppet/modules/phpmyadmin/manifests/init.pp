class phpmyadmin(
  $version,
  $db_host      = '127.0.0.1',
  $control_db   = 'phpmyadmin',
  $control_user = 'phpmyadmin',
  $control_pass = 'pmapass'
) {

	class { 'phpmyadmin::package':
		version => $version
	}

	class { 'phpmyadmin::config':
		version       => $version,
    db_host       => $db_host,
    control_db    => $control_db,
    control_user  => $control_user,
    control_pass  => $control_pass
	}

	class { 'phpmyadmin::extended_config':
		version       => $version,
    db_host       => $db_host,
    control_db    => $control_db,
    control_user  => $control_user,
    control_pass  => $control_pass
	}

}
