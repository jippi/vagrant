class augeas::lenses {

  file { "/usr/share/augeas/lenses/contrib":
    ensure  => directory,
    recurse => true,
    purge   => true,
    force   => true,
    mode    => '0644',
    owner   => "root",
    group   => "root"
  }

}
