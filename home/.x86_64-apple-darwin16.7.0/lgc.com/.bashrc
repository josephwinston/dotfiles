#
# $Id: .bashrc,v 1.1 2004/08/09 23:13:08 CVS_jody Exp $
#

alias ls ls -G
alias ldd "otool -L"

alias setProxy . ${HOME}/Tools/bin/setProxy.sh

#
# This is a little like `zap' from Kernighan and Pike
#

zap()
{
   local pid
   
   pid=$(ps -ax | grep $1 | grep -v grep | awk '{ print $1 }')
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

# alias ls "ls -C --color=auto"

# alias versions "rpm -q -a --queryformat '%{NAME} %{VERSION}\n'"

# alias from "frm"

#
# xcode 5 and 6
#

# alias use_xcode5 "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"
# alias use_xcode6 "sudo xcode-select -switch /Applications/Xcode-Beta.app/Contents/Developer"
# alias swift "xcrun swift"

#
# Spit out the drive given the name of the volume, eg eject /Volume/JBW
#

eject()
{
   diskutil unmount `df|grep "$1"`
}

#
# Don't kick in the discrete GPU
#

chrome()
{
    open '/Applications/Google Chrome.app' --args --force_integrated_gpu
}

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
    . /opt/local/etc/profile.d/bash_completion.sh
fi

#
# Git completion
#

if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi
    
#
# Docker
#

if [ -f /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion ]; then
    . /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
fi

if [ -f /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion ]; then
    . /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
fi

if [ -f /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion ]; then
    . /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
fi

#
# add homeshick
#

if [ -f "$HOME/.homesick/repos/homeshick/homeshick.sh" ]; then
    . "$HOME/.homesick/repos/homeshick/homeshick.sh"
fi

if [ -e "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash" ]; then
   . "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
fi

#
# add iterm2 integration
#

if [ -e $HOME/.iterm2_shell_integration.bash ]; then
    . $HOME/.iterm2_shell_integration.bash
fi

#
# Setup tab and window title functions for iterm2 iterm behaviour:
# until window name is explicitly set, it'll always track tab title.
# So, to have different window and tab titles, iterm_window() must be
# called first. iterm_both() resets this behaviour and has window
# track tab title again).
#
# Source: http://superuser.com/a/344397
#

set_iterm_name() {
  mode=$1; shift
  echo -ne "\033]$mode;$@\007"
}

iterm_both () { set_iterm_name 0 $@; }
iterm_tab () { set_iterm_name 1 $@; }
iterm_window () { set_iterm_name 2 $@; }
