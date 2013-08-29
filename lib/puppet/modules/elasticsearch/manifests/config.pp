# == Define: elasticsearch::config
#
# Configure an ElasticSearch cluster
#
# This can only be called once per server, as it modifies
# both the /etc/default/elasticsearch and /etc/elasticsearch/elasticsearch.yml file
#
# === Parameters
#
# A list of valid parameters
#
# [*cluster*]
#   The name of the cluster the ElasticSearch server should join
#
# [*memory*]
#   The amount of memory to allocate (including suffix MB or GB)
#   Should not be less than 256MB
#
# === Examples
#
#   elasticsearch::config {
#       "dev":
#            cluster => "officecloud",
#            memory => "256M"
#   }
#
# === Authors
#
# Christian Winther <cw@bownty.com>
#
# === Copyright
#
# Copyright 2012-2013 Christian Winther, unless otherwise noted.
#
define elasticsearch::config($cluster, $memory) {

	file {
		"/etc/elasticsearch/elasticsearch.yml":
			ensure  => file,
			owner   => 'root',
			group   => 'root',
			mode	=> 0644,
			content => template('elasticsearch/etc/elasticsearch/elasticsearch.yml.erb'),
			require => [
				Package['elasticsearch']
			],
			notify  => [
				Service['elasticsearch']
			];
	}

	augeas {
        "elasticsearch_${name}":
            context => "/files/etc/default/elasticsearch",
            changes => [
                "set 'ES_USER' 'elasticsearch'",
                "set 'ES_GROUP' 'elasticsearch'",
                "set 'ES_HEAP_SIZE' '$memory'",
                "set 'LOG_DIR' '/var/log/elasticsearch'",
                "set 'DATA_DIR' '/var/lib/elasticsearch'",
                "set 'WORK_DIR' '/tmp/elasticsearch'",
                "set 'CONF_DIR' '/etc/elasticsearch'",
                "set 'CONF_FILE' '/etc/elasticsearch/elasticsearch.yml'",
            ],
            require => [
            	Package["elasticsearch"]
            ],
            notify => [
            	Service["elasticsearch"]
            ];
    }

    Package["elasticsearch"]
        -> File["/etc/elasticsearch/elasticsearch.yml"]
        -> Augeas["elasticsearch_${name}"]

}
