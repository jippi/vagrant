class varnish::apt {

	apt::source { 'varnish':
		location	=> 'http://repo.varnish-cache.org/debian/',
		release   => 'squeeze',
		repos     => 'varnish-3.0',
		require		=> Exec['add_varnish_key'];
	}

	exec { 'add_varnish_key':
		command => 'curl http://repo.varnish-cache.org/debian/GPG-key.txt | apt-key add - && touch /var/local/varnish.gpg.done',
		creates => '/var/local/varnish.gpg.done';
	}

}
