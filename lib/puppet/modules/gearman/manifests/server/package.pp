class gearman::server::package {

  package { 'gearman-job-server':
    ensure => installed;
  }

}
