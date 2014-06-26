#
# $Id: //depot/Jody/main/jody/.powerpc-ibm-aix4.2.0.0/hls_ts/.bashrc#1 $
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

#
# Halliburton's workers fails if the environment variable shell is set
#

function workersInternal()
{
   local real=`builtin type -all -path workers`
   if [ "$real" = "" ]; then
      echo workers not found on $PATH
      return 1
   else
      $real
   fi
}

function workers()
{
   local usage='usage: workers'
   if [ $# -ne 0 ] ; then
      echo "$usage"
      return 1
   fi

   if [ "$SHELL" != "" ]; then
      local OLD_SHELL=$SHELL
      unset SHELL
   fi

   workersInternal
   
   if [ "$OLD_SHELL" != "" ]; then
      SHELL=$OLD_SHELL
      export SHELL
   fi
}

function setProjectInternal()
{
   local real=`builtin type -all -path set_project`
   if [ "$real" = "" ]; then
      echo set_project not found on $PATH
      return 1
   else
      source $real
   fi
}

function set_project()
{
   local usage='usage: set_project'
   if [ $# -ne 0 ] ; then
      echo "$usage"
      return 1
   fi

   setProjectInternal
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
