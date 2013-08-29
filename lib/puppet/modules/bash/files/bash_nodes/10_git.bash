# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
#
export GIT_PS1_SHOWDIRTYSTATE="yes"
export GIT_PS1_SHOWSTASHSTATE="yes"
export GIT_PS1_SHOWUNTRACKEDFILES="yes"
export GIT_PS1_SHOWUPSTREAM="auto"

blocked_users="root vagrant deploy www-data"

if ! [[ $blocked_users =~ (^| )$USER($| ) ]]
then
  # Enforce git config user.name globally
  #
  if ! git config --global user.name > /dev/null
  then
    echo ""
    echo "You have not yet configured a global git user.name setting"
    echo "This should be your real (full) name"
    echo ""
    echo -n "Enter your full name: "
    read response

    if ! git config --global user.name "$response"
    then
      echo "... failed to set user name"
      echo "... please run 'git config --global user.name <your name>' manually"
    fi
  fi

  # Enforce git config user.email globally
  #
  if ! git config --global user.email > /dev/null
  then
    echo ""
    echo "You have not yet configured a global git user.email setting"
    echo "This should be your nodes email (e.g. $USER@nodes.dk)"
    echo ""
    echo -n "Enter your work email: "
    read response

    if ! git config --global user.email "$response"
    then
      echo "... failed to set user email"
      echo "... please run 'git config --global user.email <your email>' manually"
    fi
  fi
fi
