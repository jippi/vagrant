class postfix::package {

  package {
    'postfix':
      ensure  => 'installed';

    'bsd-mailx':
      ensure  => 'installed';
    }

}
