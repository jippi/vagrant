class redis::files {

  file { '/etc/redis/redis.conf':
    owner   => 'root',
    group   => 'root',
    mode    => 644,
    ensure  => 'file',
    source  => 'puppet:///modules/redis/etc/redis/redis.conf',
    notify  => Service['redis-server'],
    require => Package['redis-server']
  }

}
