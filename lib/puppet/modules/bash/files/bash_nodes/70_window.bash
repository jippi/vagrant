# Change the window title for terminals
case $TERM in
  xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
	export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
  ;;
  screen)
	export PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
  ;;
esac
