class development::files {

  file { '/usr/local/include/git-shared-lib':
    source  => 'puppet:///modules/development/usr/local/include/git-shared-lib',
    ensure  => file,
    mode  => '0555'
  }

}
