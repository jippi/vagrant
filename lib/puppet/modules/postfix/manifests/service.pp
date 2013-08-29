class postfix::service {

  service { 'postfix':
    enable     => true,
    ensure     => "running",
    hasrestart => true,
    hasstatus  => true,
    require    => Package['postfix']
  }

}
