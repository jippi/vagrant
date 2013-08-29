class supervisor::service {

	service { 'supervisor':
		ensure 		=> running,
		require 	=> Package['supervisor'],
		hasstatus => false;
	}

	exec { 'supervisor_reload':
		command 		=> 'supervisorctl reload',
		refreshonly	=> true;
	}

}
