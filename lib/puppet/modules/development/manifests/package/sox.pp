class development::package::sox {

  package {
    'libsox-fmt-all':
      ensure => installed;

    'sox':
      ensure => installed;

    'lame':
      ensure => installed;
  }

}
