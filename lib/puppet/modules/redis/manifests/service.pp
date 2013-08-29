class redis::service {

  service { 'redis-server':
    enable      => true,
    ensure      => running,
    hasrestart  => true,
    hasstatus   => false,
    require     => Package['redis-server']
  }

}
