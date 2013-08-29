class varnish::service {

  service { 'varnish':
    enable      => true,
    ensure      => 'running',
    hasrestart  => true,
    hasstatus   => true,
    require     => [
      Package['varnish'],
      File['/usr/local/bin/varnishreload']
    ]
  }

}
