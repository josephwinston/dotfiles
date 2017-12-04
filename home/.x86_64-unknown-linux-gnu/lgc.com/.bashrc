#
# $Id: //depot/Jody/main/jody/.i686-unknown-linux/xprtcc.com/.bashrc#3 $
#

#
# This is a little like `zap' from Kernighan and Pike
#

zap()
{
   local pid
   
   pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
      if [ ! "$pid" = "" ]; then
	 echo -n "killing $1 (process $pid) ... "
	 kill -9 $pid
	 echo "done."
      fi
}


total()
{
   ls -l |gawk 'BEGIN{tot = 0;num = 0} \
    {tot += $5; num++} \
    END{printf("%d bytes in %d files\n", tot, num)}'
}

alias ls "ls -C --color=auto"

alias versions "rpm -q -a --queryformat '%{NAME} %{VERSION}\n'"

# alias from "frm"

if [ -f $HOME/src/Remote/GIT/git/contrib/completion/git-completion.bash ]; then
    . $HOME/src/Remote/GIT/git/contrib/completion/git-completion.bash
fi

#
# Open functionality
#

alias open "xdg-open"

#
# Homesick
#

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

#
# marathonctl
#

alias marathonctl "docker run --rm --net=host shoenig/marathonctl:latest"

#
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[[ -s "/home/josephwinston/.gvm/scripts/gvm" ]] && source "/home/josephwinston/.gvm/scripts/gvm"

if [ -s "/home/josephwinston/.gvm/scripts/gvm" ]; then
    gvm use system > /dev/null 2>&1 
fi



