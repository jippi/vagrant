class mysql_support::server::dynamic_config {

  create_resources('mysql::server::config', hiera_hash('mysql_config', {}))

}
