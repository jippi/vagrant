#
# https://github.com/puppetlabs/puppetlabs-firewall
#
class my_fw {

  resources { "firewall":
    purge => true
  }

  class { 'firewall': }
  create_resources('firewall', hiera_hash('firewall'))

}
