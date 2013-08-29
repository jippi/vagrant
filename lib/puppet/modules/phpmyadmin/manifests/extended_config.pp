class phpmyadmin::extended_config(
  $version,
  $db_host      = 'localhost',
  $control_db   = 'phpmyadmin',
  $control_user = 'phpmyadmin',
  $control_pass = 'pmapass'
) {

  mysql_support::db_with_user_and_grant { "$control_db":
    password => $control_pass
  }

  exec { 'load_phpmyadmin_config':
    command => "mysql -u $control_user -p$control_pass -h $db_host $control_db < /opt/phpmyadmin/phpMyAdmin-${version}-all-languages/examples/create_tables.sql",
    unless  => "mysql -u $control_user -p$control_pass -h $db_host $control_db -e 'show tables' | wc -l | grep -vq 0",
    require => [
      Class['mysql'],
      Mysql_support::Db_with_user_and_grant["$control_db"]
    ]
  }

}
