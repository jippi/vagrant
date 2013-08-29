class puppet_support::cron($ensure = 'present') {

	# running puppet from cron, to lessen the memmory hoggin
	# should run every ~30 minuts at different interval
	# fqdn_rand gives us a "random" number based on the hostname of the server
	$min1 = fqdn_rand(30)
	$min2 = fqdn_rand(30) + 30

	cron { 'manual-puppet':
		ensure 	=> $ensure,
		command => "/usr/local/sbin/puppet-run",
	  user 		=> 'root',
	  hour 		=> '*',
	  minute 	=> [$min1, $min2]
	}

}
