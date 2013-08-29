class roles::mysql {

  include mysql
  include mysql::server
  include mysql::server::account_security
  include mysql::server::mysqltuner

  include mysql_support
  include mysql_support::percona
  include mysql_support::augeas
  include mysql_support::server::config
  include mysql_support::server::dynamic_config
  include mysql_support::databases

  Class['mysql'] -> Mysql_support::Db_with_user_and_grant <| |>
  Class['mysql::server'] -> Mysql_support::Db_with_user_and_grant <| |>

  Package <| |> -> Database <| |>
  Package <| |> -> Database_User <| |>
  Package <| |> -> Database_Grant <| |>

}
