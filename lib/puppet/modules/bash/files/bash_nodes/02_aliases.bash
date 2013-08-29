alias view="vim -R"
alias l="ls -lsA --color"
alias ls="ls --color"
alias ll="ls -lsa --color"
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias less="less -j $[LINES/2]"
alias s="sudo"
alias ss="sudo su -"
alias r="su -"
alias t="tail -f"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias b="cd -"
alias go="ssh -A"
alias rs="rsync -avz --delete -e ssh"
alias rsn="sync -n"
alias sshagent='mkdir -p `dirname $SSH_AUTH_SOCK` 2> /dev/null; ssh-agent -a $SSH_AUTH_SOCK -t 36000'
alias sshadd='ssh-add -t 36000'
alias xkeych="setxkbmap -layout ch"
alias xkeyus="setxkbmap -layout us -variant altgr-intl"

alias shutdown="savealias shutdown"
alias halt="savealias halt"
alias reboot="ask && /sbin/shutdown -r now"
alias init="savealias init"

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

alias cdp=nodes-project-cd
alias gh=git-nodes-home
alias nbackup="nodes-sql backup"
alias nschema="nodes-sql schema"
alias nsql="nodes-sql console"

for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do
	alias "$method"="curl -s -X${method}"
done
