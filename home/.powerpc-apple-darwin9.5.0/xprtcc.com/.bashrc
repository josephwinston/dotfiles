#
# $Id: .bashrc,v 1.1 2004/08/09 23:13:08 CVS_jody Exp $
#

alias ls ls -G

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
