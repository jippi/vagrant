umask 0002

export LSCOLORS="ExGxdxdxCxBxBxacacaeae"
export EDITOR="pico"
export PAGER="less"

export PATH="$PATH:~/bin"
export PATH="$PATH:/var/lib/gems/1.8/bin"
export PATH="$PATH:/var/lib/gems/1.9/bin"
export PATH="$PATH:/home/shared/bin"
export PATH="$PATH:./node_modules/.bin"

# set lc_all to avoid perl errors in some shells
export LC_ALL="en_GB.UTF-8"

# Make sure to user .github file
git_ssh_wrapper="$HOME/.github"
if [ -e "$git_ssh_wrapper" ]
then
  export GIT_SSH="$git_ssh_wrapper"
fi

# Don't reset (agent forwarding)
# Don't put on network filesystem
[ -z "$SSH_AUTH_SOCK" ] && export SSH_AUTH_SOCK="/tmp/ssh-agent-$USER/sock"

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoreboth
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups

# Don’t clear the screen after quitting a manual page
export MANPAGER="less -X"

## http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html

# append to the history file, don't overwrite it
shopt -s histappend

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# If set, Bash attempts spelling correction on directory names during word completion if the directory name initially supplied does not exist.
shopt -s dirspell

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac
