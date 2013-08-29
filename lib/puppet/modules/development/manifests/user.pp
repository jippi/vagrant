define development::user(
	$ensure					= present,
	$uid						= 33,
	$gid						= 33,
	$password				= 'bownty10',
	$shell 					= '/bin/bash',
	$ssh_public_key	= false,
	$ssh_private_key= false,
	$comment				= '',
) {

	user { $name:
		ensure			=> $ensure,
		name				=> $name,
		uid					=> $uid,
		gid					=> $gid,
		groups			=> $name,
		password		=> $password,
		comment			=> $comment,
		shell				=> $shell,
		allowdupe		=> true,
		membership	=> "inclusive",
		managehome	=> true,
		home				=> "/home/${name}/",
		require			=> Group[$name];
	}

	group { $name:
		ensure					=> "present",
		name						=> $name,
		auth_membership => false;
	}

	if ($ssh_public_key) {
		file {
			"/home/$name/.ssh/id_rsa.pub":
				ensure		=> $ensure,
				source		=> "/etc/bownty/config/users/$name/.ssh/id_rsa.pub",
				mode 			=> "0600",
				owner			=> $uid,
				group			=> $gid,
				require 	=> File["/home/$name/.ssh"];

			"/home/$name/.ssh/authorized_keys":
				ensure	=> $ensure,
				source	=> "/etc/bownty/config/users/$name/.ssh/id_rsa.pub",
				mode 		=> "0600",
				owner		=> $uid,
				group		=> $gid,
				require => File["/home/$name/.ssh"];
		}

		File["/home/$name/.ssh"] -> File["/home/$name/.ssh/id_rsa.pub"]
		File["/home/$name/.ssh"] -> File["/home/$name/.ssh/authorized_keys"]
	}

	if ($ssh_private_key) {
		file { "/home/$name/.ssh/id_rsa":
			ensure	=> $ensure,
			source	=> "/etc/bownty/config/users/$name/.ssh/id_rsa",
			mode 		=> "0600",
			owner		=> $uid,
			group		=> $gid,
			require => File["/home/$name/.ssh"];
		}

		File["/home/$name/.ssh"] -> File["/home/$name/.ssh/id_rsa"]
	}

	if ($ensure == 'present') {
		file {
			# Create homefolder
			"/home/${name}":
				require 	=> User[$name],
				ensure		=> 'directory',
				source		=> "/etc/bownty/config/users/${name}",
				recurse		=> true,
				force 		=> true,
				replace		=> true,
				owner			=> $uid,
				group			=> $gid,
				ignore		=> ".git";

			"/home/${name}/.hushlogin":
				ensure 	=> file,
				content	=> "";

			"/home/${name}/.bashrc":
				ensure	=> link,
				force		=> true,
				replace	=> true,
				target	=> "/etc/bash.bashrc";

			# Github settings
			"/home/${name}/.github":
				content => template('development/bin/github'),
				ensure	=> 'file',
				owner		=> $uid,
				group		=> $gid,
				mode		=> "0700";

			# Configure SSH
			"/home/${name}/.ssh":
				require => File["/home/${name}"],
				ensure	=> 'directory',
				owner		=> $uid,
				group		=> $gid,
				mode		=> "0700";

			"/home/${name}/www":
				require => File["/home/${name}"],
				ensure	=> '/var/www',
				owner		=> "www-data",
				group		=> "www-data",
				mode		=> "0700";
		}
	}
}
