class logstash_support {

  essentials::apt::localpackage { "logstash":
    url => "http://logstash.objects.dreamhost.com/pkg/debian/logstash_${::logstash::version}_all.deb";
  }

  Essentials::Apt::Localpackage['logstash'] ~> Exec["apt_update"]

  file { '/var/lib/logstash/logstash.jar':
    ensure => link,
    target => '/opt/logstash/logstash-1.1.13-flatjar.jar',
    before => Service['logstash-agent']
  }

  file { '/etc/init.d/logstash':
    ensure => absent
  }

}
