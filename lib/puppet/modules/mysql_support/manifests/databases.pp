class mysql_support::databases() {

  create_resources('mysql_support::db_with_user_and_grant', hiera_hash('mysql_database', {}))

}
