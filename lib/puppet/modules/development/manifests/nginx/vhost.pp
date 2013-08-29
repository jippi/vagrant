define development::nginx::vhost(
    $template = 'development/etc/nginx/default.erb',
    $password = '',
    $source = '',
    $supervisord = false
) {

  if !defined(File["/var/www"]) {
  file {
    "/var/www":
      ensure => 'directory',
      mode   => '0774',
      owner  => 'root',
      group  => 'root';
    }
  }

  file {
    "/var/www/${name}":
      ensure => 'directory',
      mode   => '0774',
      owner  => 'root',
      group  => 'root';

    "/var/www/${name}/logs":
      ensure => 'directory',
      mode   => '0774',
      owner  => 'www-data',
      group  => 'www-data';

    "/var/www/${name}/htdocs":
      ensure => 'directory',
      mode   => '0774',
      owner  => 'www-data',
      group  => 'www-data';

    "/var/www/${name}/backup":
      ensure => 'directory',
      mode   => '0777',
      owner  => 'www-data',
      group  => 'www-data';

    "/etc/nginx/sites-enabled/${name}":
      ensure  => file,
      mode    => '0777',
      content => template($template),
      owner   => 'root',
      group   => 'root',
      notify  => Service['nginx'];

    "/var/www/${name}/database.php":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => template('development/cakephp/database.php.erb');

    "/var/www/${name}/database.sh":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => template('development/cakephp/database.sh.erb');

    "/var/www/${name}/env.php":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => template('development/cakephp/production.php.erb');

#    "/var/www/${name}/htdocs/app/webroot/debug_kit":
#      ensure  => link,
#      target  => "/usr/share/php/plugins/DebugKit/webroot",
#      force   => true,
#      owner   => www-data,
#      group   => www-data;
  }

  if ($supervisord) {
    file { "/etc/supervisor/conf.d/${name}.conf":
          ensure  => link,
          source  => "/var/www/$name/htdocs/app/Config/supervisor.conf";
      }
  } else {
      file { "/etc/supervisor/conf.d/${name}.conf":
          ensure => absent;
      }
  }

  File['/usr/local/bin/']
    -> Package['php5-fpm']
    -> File['/var/www']
    -> File["/var/www/${name}"]
    -> File["/var/www/${name}/logs"]
    -> File["/var/www/${name}/backup"]
    -> File["/var/www/${name}/htdocs"]
    -> File["/etc/nginx/sites-enabled/${name}"]
    -> File["/var/www/${name}/database.php"]
    -> File["/var/www/${name}/database.sh"]
    -> File["/var/www/${name}/env.php"]
    ~> Exec["supervisor_reload"]

}
