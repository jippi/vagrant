class mysql_support::percona {

  #
  # http://www.percona.com/doc/percona-server/5.5/installation/apt_repo.html
  #
  apt::source { 'mysql_percona':
    location    => 'http://repo.percona.com/apt',
    release     => 'wheezy',
    repos       => 'main',
    key         => 'CD2EFD2A',
    include_src => false
  }

  # Cleanup
  #
  package { ['mysql-server-core-5.5', 'mysql-common', 'mysql-server-5.5' ]:
    ensure => purged,
    before => [
      Package['percona-server-client-5.6'],
      Package['percona-server-server-5.6']
    ]
  }

}
