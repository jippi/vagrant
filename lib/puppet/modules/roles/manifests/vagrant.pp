class roles::vagrant {

  sudo::conf { 'vagrant':
    priority => 10,
    content  => "vagrant ALL=(ALL) NOPASSWD: ALL",
  }

  $sites = loadyaml('/etc/bownty/config/sites.yaml')
  if $sites {
    create_resources(mysql_support::db_with_user_and_grant, $sites)
    create_resources(development::nginx::vhost, $sites)
  }

  file { '/var/www/.ssh':
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0700',
    recurse => true
  }

}
