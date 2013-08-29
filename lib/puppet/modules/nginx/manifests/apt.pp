class nginx::apt {

  apt::source { 'dotdeb_primary':
    location    => 'http://packages.dotdeb.org',
    release     => 'wheezy',
    repos       => 'all',
    include_src => false
  }

  Exec['add_dotdeb_key'] -> Apt::Source['dotdeb_primary']

}
