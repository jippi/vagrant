class redis::package($version = 'installed') {

  package { 'redis-server':
    ensure  => $version
  }

}
