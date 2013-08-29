class ssh::server::config::allow_password($ensure = 'enabled') {

	augeas { "ssh-allow-password-auth":
		context => "/files/etc/ssh/sshd_config",
		changes => [
			$ensure ? {
				enabled => "set PasswordAuthentication 'yes'",
				default => "set PasswordAuthentication 'no'"
			}
		],
		notify => Service['ssh']
	}

}
