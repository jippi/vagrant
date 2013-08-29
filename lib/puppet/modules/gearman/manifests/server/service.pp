class gearman::server::service {

  service { 'gearman-job-server':
    ensure    => running,
    hasstatus => false,
    require   => Class['gearman::server::package']
  }

}
