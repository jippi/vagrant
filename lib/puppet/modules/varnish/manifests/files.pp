class varnish::files {

  file {
    '/usr/local/bin/varnishreload':
      ensure  => 'file',
      mode    => '0744',
      owner   => 'root',
      group   => 'root',
      source  => 'puppet:///modules/varnish/usr/local/bin/varnishreload';

  '/etc/default/varnish':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/varnish/etc/default/varnish',
    require => Package['varnish'],
    notify  => Service['varnish'];

  '/etc/varnish/default.vcl':
    ensure  => 'file',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    source  => 'puppet:///modules/varnish/etc/varnish/default.vcl',
    require => Package['varnish'],
    notify  => Service['varnish'];
  }

}
