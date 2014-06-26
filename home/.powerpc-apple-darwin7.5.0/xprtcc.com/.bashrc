#
# $Id: //depot/Jody/main/jody/.powerpc-apple-darwin7.5.0/xprtcc.com/.bashrc#1 $
#

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
