class phpmyadmin::config(
  $version,
  $db_host      = 'localhost',
  $control_db   = 'phpmyadmin',
  $control_user = 'phpmyadmin',
  $control_pass = 'pmapass'
) {

  file { "/opt/phpmyadmin/phpMyAdmin-${version}-all-languages/config.inc.php":
    content => template("phpmyadmin/config/config.inc.php.erb")
  }

  Exec["phpmyadmin_extract"] -> File["/opt/phpmyadmin/phpMyAdmin-${version}-all-languages/config.inc.php"]

}
