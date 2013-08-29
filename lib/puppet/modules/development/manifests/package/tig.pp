class development::package::tig() {

  $version = "1.1"

  file { '/opt/tig':
    ensure => "directory",
    recurse => true;
  }

  package {['libncurses5', 'libncurses5-dev']:
    ensure => installed
  }

  exec {
    'tig_fetch':
      command => "wget http://jonas.nitro.dk/tig/releases/tig-${version}.tar.gz",
      creates => "/opt/tig/tig-${version}.tar.gz",
      cwd     => '/opt/tig';

    'tig_extract':
      command => "tar zxf tig-${version}.tar.gz",
      creates => "/opt/tig/tig-${version}",
      cwd     => '/opt/tig';

    'tig_configure':
      command => 'bash -c -- ./configure',
      creates => "/opt/tig/tig-${version}/config.status",
      cwd     => "/opt/tig/tig-${version}";

    'tig_make':
      command => 'make',
      creates => "/opt/tig/tig-${version}/tig",
      cwd     => "/opt/tig/tig-${version}";

    'tig_install':
      command => 'make install',
      creates => '/usr/local/bin/tig',
      cwd     => "/opt/tig/tig-${version}";
  }

  File['/opt']
    -> File['/opt/tig']
    -> Package['build-essential']
    -> Package['libncurses5']
    -> Package['libncurses5-dev']
    -> Exec['tig_fetch']
    -> Exec['tig_extract']
    -> Exec['tig_configure']
    -> Exec['tig_make']
    -> Exec['tig_install']

}
