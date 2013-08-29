class nodejs::package($version) {

  file { "/opt/nodejs":
    ensure => directory;
  }

  exec {
    "nodejs_download":
      command => "/usr/bin/curl -L -s -C - -O http://nodejs.org/dist/v${version}/node-v${version}-linux-x64.tar.gz",
      cwd     => "/opt/nodejs",
      creates => "/opt/nodejs/node-v${version}-linux-x64.tar.gz";

    "nodejs_extract":
      command => "tar zxf node-v${version}-linux-x64.tar.gz",
      cwd     => "/opt/nodejs",
      creates => "/opt/nodejs/node-v${version}-linux-x64";
  }

  file {
    "/usr/local/bin/node":
      ensure  => link,
      force   => true,
      target  => "/opt/nodejs/node-v${version}-linux-x64/bin/node",
      require => Exec['nodejs_extract'];

    "/usr/local/bin/node-waf":
      ensure  => link,
      force   => true,
      target  => "/opt/nodejs/node-v${version}-linux-x64/bin/node-waf",
      require => Exec['nodejs_extract'];

    "/usr/local/bin/npm":
      ensure  => link,
      force   => true,
      target  => "/opt/nodejs/node-v${version}-linux-x64/bin/npm",
      require => Exec['nodejs_extract'];
  }

  File['/opt']
    -> File["/opt/nodejs"]
    -> Exec["nodejs_download"]
    -> Exec["nodejs_extract"]
    -> File["/usr/local/bin/node"]
    -> File["/usr/local/bin/node-waf"]
    -> File["/usr/local/bin/npm"]

}
