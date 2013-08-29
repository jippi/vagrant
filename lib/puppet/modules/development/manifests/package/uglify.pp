class development::package::uglify {

  package { 'uglify-js':
    ensure   => installed,
    provider => npm
  }

  File['/usr/local/bin/npm'] -> Package['uglify-js']

}
