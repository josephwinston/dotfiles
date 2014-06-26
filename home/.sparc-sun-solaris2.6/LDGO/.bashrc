#
# $Id: //depot/Jody/main/jody/.sparc-sun-solaris2.6/LDGO/.bashrc#1 $
#

#
# This is a little like `zap' from Kernighan and Pike
#

function zap()
{
   local pid
   
   local usage='usage: zap program'
   if [ $# -eq 0 ] ; then
      echo "$usage"
      return 1
   fi

   pid=$(ps -el | grep $1 | grep -v grep | awk '{ print $4 }')
      if [ ! "$pid" = "" ]; then
	 echo -n "killing $1 (process $pid) ... "
	 kill -9 $pid
	 echo "done."
      fi
}

function total()
{
   ls -l |gawk 'BEGIN{tot = 0;num = 0} \
    {tot += $5; num++} \
    END{printf("%d bytes in %d files\n", tot, num)}'
}

function ldd()
{
   local usage='usage: ldd file ...'
   if [ $# -eq 0 ] ; then
      echo "$usage"
      return 1
   fi
   
   elfdump -Dl $*
}

if [ $TERM != "emacs" ]; then
   alias ls "ls -C --color=auto"
fi




