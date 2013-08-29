class nginx::www_shell {

  user { "www-data":
    ensure     => present,
    home       => "/var/www",
    managehome => true,
    shell      => "/bin/bash",
    uid        => '33',
    gid        => '33',
    comment    => "www data"
  }

}
