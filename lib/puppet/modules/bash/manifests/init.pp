class bash {
	file {
		"/etc/bash_completion.d/git-completion.bash":
			source => "puppet:///modules/bash/bash_completion.d/git.bash";

		"/etc/bash_completion.d/git-flow-completion.bash":
			source => "puppet:///modules/bash/bash_completion.d/git-flow.bash";

		"/etc/bash.bashrc":
			source => "puppet:///modules/bash/bash.bashrc";

		"/etc/inputrc":
			source => "puppet:///modules/bash/inputrc";

		"/etc/bash_nodes/":
			ensure 	=> "directory",
			source 	=> "puppet:///modules/bash/bash_nodes/",
			recurse	=> true,
			force	=> true,
			purge	=> true;

		"/etc/bash":
			ensure 	=> absent,
			recurse	=> true,
			force		=> true;
	}
}
