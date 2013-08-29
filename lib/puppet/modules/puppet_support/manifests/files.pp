class puppet_support::files($manifest) {

  file { '/usr/local/sbin/puppet-run':
    ensure  => link,
    target  => '/etc/puppet/bin/puppet-run'
  }

  file { '/usr/local/sbin/puppet-update':
    ensure  => link,
    target  => '/etc/puppet/bin/puppet-update'
  }

  file { '/usr/local/sbin/puppet-apply':
    ensure  => file,
    mode    => '0744',
    owner   => 'root',
    group   => 'root',
    content => template('puppet_support/sbin/puppet-apply');
  }

  file { '/usr/local/sbin/facter-ec2-update-tags':
    ensure  => absent;
  }

  file { '/etc/facter/facts.d/ec2':
    ensure  => absent;
  }

  file { '/etc/puppet/hieradata/ec2.yaml':
    ensure => absent;
  }

  file { '/opt/aws.phar':
    ensure => absent;
  }

  file { '/opt/php':
    ensure  => directory,
    mode    => '0744',
    owner   => root,
    group   => root;
  }

  file { '/opt/php/composer.json':
    ensure  => file,
    mode    => '0744',
    owner   => root,
    group   => root,
    source  => 'puppet:///modules/puppet_support/php_composer.json',
    require => File['/opt/php'];
  }

  exec { 'composer install':
    cwd         => '/opt/php',
    subscribe   => File['/opt/php/composer.json'],
    refreshonly => true,
    environment => 'HOME=/tmp'
  }

}
