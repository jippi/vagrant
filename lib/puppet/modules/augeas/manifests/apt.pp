class augeas::apt {

  #
  # https://launchpad.net/~raphink/+archive/augeas
  #
  apt::source { 'ppa_augeas':
    location    => 'http://ppa.launchpad.net/raphink/augeas/ubuntu',
    release     => 'lucid',
    repos       => 'main',
    key         => 'AE498453',
    include_src => false
  }

}
