class essentials::ssh_users {

  create_resources('user', hiera_hash('ssh_users', {}))

}
