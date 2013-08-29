# == Class: mysql::server::config
#
# mysql server config class
#
#  - Change bind-address to 0.0.0.0
#  - Enable logging of slow SQL
#  - Define slow query as 2 seconds
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include mysql::server::config
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
class mysql_support::server::config {

  augeas { 'Basic MySQL settings':
    context   => '/files/etc/mysql/conf.d/basic.cnf/mysqld/',
    load_path => '/usr/share/augeas/lenses/contrib/',
    changes   => [
      'set bind-address 0.0.0.0',
      'set long_query_time 2',
      'set wait_timeout 31536000',
      'set ft_min_word_len 3',
      'set innodb_file_per_table 1',
      'set tmpdir /tmp',
      'set binlog_format row',
      'set max_connections 100',
      'set max_allowed_packet 100G',

      'set innodb_flush_log_at_trx_commit 2',
      'set innodb_flush_method O_DIRECT',
      'set innodb_log_files_in_group 2',
      'set innodb_commit_concurrency 0',
      'set innodb_thread_concurrency 16',
      'set innodb_concurrency_tickets 500',
      'set innodb_file_io_threads 4',

      'rm log-queries-not-using-indexes',
      'rm log_slow_queries',
    ];
  }

  File['/usr/share/augeas/lenses/contrib/mysql.aug'] -> Augeas['Basic MySQL settings']

  Augeas['Basic MySQL settings'] ~> Service['mysql']

}
