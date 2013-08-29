class essentials::hostname($host, $domain) {

  host { "${host}.${domain}":
    ensure        => present,
    ip            => $ipaddress,
    before        => Exec['hostname.sh'],
    comment       => 'hostname managed by puppet',
    host_aliases  => [
      inline_template("<%= @host -%>")
    ]
  }

  file { '/etc/mailname':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "${host}\n",
    notify  => Service['postfix'],
  }

  file { '/etc/hostname':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => inline_template("<%= @host.split('.', 2).first %>"),
    notify  => [
      Exec['hostname.sh'],
      Service['postfix']
    ]
  }

  exec { 'hostname.sh':
    command     => '/etc/init.d/hostname.sh start',
    refreshonly => true
  }

  augeas { '/etc/resolv.conf':
    context => '/files/etc/resolv.conf',
    changes => [
      "set 'domain' '${domain}'",
      "set 'search/domain' '${domain}'"
    ]
  }

}
