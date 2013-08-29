_nodes-project-cd () {
	local cur opts

	if [[ ${COMP_CWORD} = 1 ]] ; then
		cur="${COMP_WORDS[COMP_CWORD]}"
		opts=$(/bin/ls var/www)

		COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
		return 0
	fi

	return 0;
}
complete -F _nodes-project-cd nodes-project-cd
