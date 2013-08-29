# Color prompt
if [[ $EUID == 0 ]] ; then
  export PS1='\[\e[1;31m\]\u \[\e[0m\]@ \[\e[1;33m\]\H \[\e[0m\][ \[\e[1;34m\]\w \[\e[0m\]]$(__git_ps1 " (%s)")\n\[\e[1m\]-> \[\e[0m\]'
else
  export PS1='\[\e[1;32m\]\u \[\e[0m\]@ \[\e[1;33m\]\H \[\e[0m\][ \[\e[1;34m\]\w \[\e[0m\]]$(__git_ps1 " (%s)")\n\[\e[1m\]-> \[\e[0m\]'
fi
