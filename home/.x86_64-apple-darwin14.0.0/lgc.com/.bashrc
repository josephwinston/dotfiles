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

growl() 
{ 
    echo -e $'\e]9;'${1}'\007'; 
    return; 
}

# alias ls "ls -C --color=auto"

# alias versions "rpm -q -a --queryformat '%{NAME} %{VERSION}\n'"

# alias from "frm"

#
# xcode 5 and 6
#

alias use_xcode5 "sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer"
alias use_xcode6 "sudo xcode-select -switch /Applications/Xcode6-Beta4.app/Contents/Developer"
alias swift "xcrun swift"

#
# Git completion
#


if [ -f /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash ]; then
    . /Library/Developer/CommandLineTools/usr/share/git-core/git-completion.bash
fi
    
#
# Docker
#

export DOCKER_HOST=tcp://192.168.59.103:2375

if [ -f ~/Tools/x86_64-apple-darwin14.0.0/share/docker-completion.bash ]; then
    . ~/Tools/x86_64-apple-darwin14.0.0/share/docker-completion.bash
fi

#
# See http://blog.sequenceiq.com/blog/2014/07/05/docker-debug-with-nsenter-on-boot2docker/
#

docker-enter() 
{
    boot2docker ssh '[ -f /var/lib/boot2docker/nsenter ] || docker run --rm -v /var/lib/boot2docker/:/target jpetazzo/nsenter'
    boot2docker ssh -t sudo /var/lib/boot2docker/docker-enter "$@"
}

#
# add homeshick
#

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
