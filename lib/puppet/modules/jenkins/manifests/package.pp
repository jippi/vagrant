class jenkins::package($version = 'latest') {

  package { 'openjdk-7-jre-headless':
    ensure => installed
  }

  package { ['ant', 'ant-contrib']:
    ensure => installed
  }

  package { 'jenkins':
    ensure  => $version,
    notify  => Package['jenkins'],
    require => Package['openjdk-7-jre-headless']
  }

}
