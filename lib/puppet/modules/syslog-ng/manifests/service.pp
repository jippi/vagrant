class syslog-ng::service {

  service { 'syslog-ng':
    enable      => true,
    ensure      => "running",
    hasrestart  => true,
    hasstatus   => false,
    require     => Package['syslog-ng'];
  }

}
