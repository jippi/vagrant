class jenkins::apt {

  apt::source { 'jenkins':
    location      => 'http://pkg.jenkins-ci.org/debian',
    release       => 'binary/',
    repos         => '',
    key           => 'D50582E6',
    include_src   => false
  }

}
