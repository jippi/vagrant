define nginx::vhost(
  $db_host = undef,
  $db_username = undef,
  $db_password = undef,
  $db_name = undef
) {

  if $db_host == undef {
    $database_host = 'localhost'
  } else {
    $database_host = $db_host
  }

  if $db_username == undef {
    $database_username = $name
  } else {
    $database_username = $db_username
  }

  if $db_name == undef {
    $database_name = $name
  } else {
    $database_name = $db_name
  }

  $database_password = $db_password

  if !defined(File["/var/www"]) {
    file { "/var/www":
      ensure => directory,
      mode   => '0774',
      owner  => 'www-data',
      group  => 'www-data';
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
      content => inline_template(
        file(
          "/etc/puppet/modules/$environment/templates/nginx/vhost/$name.$hostname.erb",
          "/etc/puppet/modules/$environment/templates/nginx/vhost/$name.erb",
          "/etc/puppet/modules/$environment/templates/nginx/vhost/default.erb",

          "/etc/puppet/modules/nginx/templates/vhost/$name.$hostname.erb",
          "/etc/puppet/modules/nginx/templates/vhost/$name.erb",
          "/etc/puppet/modules/nginx/templates/vhost/default.erb"
        )
      ),
      owner   => 'root',
      group   => 'root',
      notify  => Service['nginx'];

    "/var/www/${name}/database.php":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => inline_template(
        file(
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.php.$name.$hostname.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.php.$name.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.php.erb",

          "/etc/puppet/modules/nginx/templates/cakephp/database.php.$name.$hostname.erb",
          "/etc/puppet/modules/nginx/templates/cakephp/database.php.$hostname.erb",
          '/etc/puppet/modules/nginx/templates/cakephp/database.php.erb'
        )
      );

    "/var/www/${name}/database.sh":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => inline_template(
        file(
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.sh.$name.$hostname.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.sh.$name.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/database.sh.erb",

          "/etc/puppet/modules/nginx/templates/cakephp/database.sh.$name.$hostname.erb",
          "/etc/puppet/modules/nginx/templates/cakephp/database.sh.$hostname.erb",
          '/etc/puppet/modules/nginx/templates/cakephp/database.sh.erb'
        )
      );

    "/var/www/${name}/env.php":
      ensure  => file,
      mode    => '0774',
      owner   => 'www-data',
      group   => 'www-data',
      content => inline_template(
        file(
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/env.php.$name.$hostname.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/env.php.$name.erb",
          "/etc/puppet/modules/$environment/templates/nginx/cakephp/env.php.erb",

          "/etc/puppet/modules/nginx/templates/cakephp/env.php.$name.$hostname.erb",
          "/etc/puppet/modules/nginx/templates/cakephp/env.php.$hostname.erb",
          '/etc/puppet/modules/nginx/templates/cakephp/env.php.erb'
        )
      );
  }

  File['/var/www']
    -> File["/var/www/${name}"]
    -> File["/var/www/${name}/logs"]
    -> File["/var/www/${name}/backup"]
    -> File["/var/www/${name}/htdocs"]
    -> File["/etc/nginx/sites-enabled/${name}"]
    -> File["/var/www/${name}/database.php"]
    -> File["/var/www/${name}/database.sh"]
    -> File["/var/www/${name}/env.php"]

}
