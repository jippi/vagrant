class nginx::geo_ip {

  package { 'geoip-database':
    ensure => purged,
    before => Package['nginx-extras'],
    notify => Service['nginx']
  }

  exec { 'download_geocity_city_db':
    command => 'wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && gunzip GeoLiteCity.dat.gz',
    creates => '/usr/share/GeoIP/GeoLiteCity.dat',
    cwd     => '/usr/share/GeoIP/'
  }

  augeas { "nginx-geoip-config":
    context => "/files/etc/nginx/nginx.conf/http",
    notify  => Service['nginx'],
    require => [
      Package['geoip-database'],
      Exec['download_geocity_city_db']
    ],
    changes => [
      'rm geoip_country',
      'set geoip_city "/usr/share/GeoIP/GeoLiteCity.dat"'
    ]
  }

}
