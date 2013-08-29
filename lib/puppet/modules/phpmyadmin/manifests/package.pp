class phpmyadmin::package($version) {

  file { '/opt/phpmyadmin':
      ensure => 'directory';
  }

  exec {
    'phpmyadmin_download':
      command => "/usr/bin/curl -L -s -C - -O http://garr.dl.sourceforge.net/project/phpmyadmin/phpMyAdmin/${version}/phpMyAdmin-${version}-all-languages.tar.gz",
      cwd     => '/opt/phpmyadmin',
      creates => "/opt/phpmyadmin/phpMyAdmin-${version}-all-languages.tar.gz";

    'phpmyadmin_extract':
      command => "tar zxf phpMyAdmin-${version}-all-languages.tar.gz",
      cwd     => '/opt/phpmyadmin',
      creates => "/opt/phpmyadmin/phpMyAdmin-${version}-all-languages";
    }

    file { '/opt/phpmyadmin/phpmyadmin':
      ensure  => link,
      target  => "/opt/phpmyadmin/phpMyAdmin-${version}-all-languages",
      force   => true,
      replace => true
    }

  File['/opt']
    -> File['/opt/phpmyadmin']
    -> Exec['phpmyadmin_download']
    -> Exec['phpmyadmin_extract']
    -> File['/opt/phpmyadmin/phpmyadmin']

}
