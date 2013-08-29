class augeas($version = 'latest') {

  include augeas::apt
  include augeas::lenses

  package { ["libaugeas0", "augeas-tools", "augeas-lenses"]:
     ensure   => $version,
     before   => File["/usr/share/augeas/lenses/contrib"],
     require  => Apt::Source['ppa_augeas']
  }

  package { ["libaugeas-ruby1.8", 'libaugeas-ruby1.9.1']:
    ensure    => latest,
    require   => Apt::Source['ppa_augeas']
  }

}
