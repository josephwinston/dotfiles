function shadowTree ()
{
   echo "$HOME/gm"
}

function masterTree ()
{
   echo "/d/gm"
}

function grepalias () 
{ 
   local usage='usage: grepalias alias'
   if [ $# -ne 1 ] ; then
      echo "$usage"
      return 1
   fi
   nawk "{if (\$1 == \"$1\") print \$2}" < `masterTree`/src/admin/ckaliases
}

function pathToAlias () 
{ 
   local usage='usage: pathToAlias path'
   if [ $# -ne 1 ] ; then
      echo "$usage"
      return 1
   fi
   local dir=`echo $1|sed s@^$HOME/gm/src/@@`
   nawk "{if (\$2 == \"$dir\") print \$1}" < `masterTree`/src/admin/ckaliases
}

function aliasToPath () 
{ 
   local usage='usage: aliasToPath alias'
   if [ $# -ne 1 ] ; then
      echo "$usage"
      return 1
   fi
   nawk "{if (\$1 == \"$1\") printf (\"$HOME/gm/src/%s\n\", \$2)}" < `masterTree`/src/admin/ckaliases
}

function cdiInternal ()
{
   local location=`grepalias ${1}inc`
   local dir=${2}/src/${location}
   if [ "$location" = "" ]; then
      echo "Can't find alias ${1}inc"
      return 1
   elif [ ! -d $dir ]; then
      echo "${dir} does not exist"
      return 1
   else
      eval cd ${dir}
   fi
}

function cdsInternal ()
{
   if [ $# -ne 2 ] ; then
      cd $1/src
   else
      local location=`grepalias ${1}`
      local dir=${2}/src/${location}
      if [ "$location" = "" ]; then
	 echo "Can't find alias ${1}"
	 return 1
      elif [ ! -d $dir ]; then
	 echo "${dir} does not exist"
	 return 1	
      else
	 eval cd ${dir}
      fi
   fi
}

function cdoInternal ()
{
   if [ $# -ne 2 ] ; then
      cd $1/obj.${OBJ_EXT}
   else
      local location=`grepalias ${1}`
      local dir=${2}/obj.${OBJ_EXT}/${location}
      if [ "$location" = "" ]; then
	 echo "Can't find alias ${1}"
	 return 1
      elif [ ! -d $dir ]; then
	 echo "${dir} does not exist"
	 return 1	
      else
	 eval cd ${dir}
      fi
   fi
}

#
# Shadow Tree
#

function cdi ()
{
   cdiInternal $1 `shadowTree`
}

function cds ()
{
   cdsInternal $1 `shadowTree`
}

function cdo ()
{
   cdoInternal $1 `shadowTree`
}

#
# Master Tree
#

function cddi ()
{
   cdiInternal $1 `masterTree`
}

function cdds ()
{
   cdsInternal $1 `masterTree`
}

function cddo ()
{
   cdoInternal $1 `masterTree`
}

function gmci ()
{
   local real=`builtin type -all -path gmci`
   if [ "$real" = "" ]; then
      echo gmci not found
   else
      $real -s `pathToAlias $PWD` $*
   fi
}

function gmco ()
{
   local real=`builtin type -all -path gmco`
   if [ "$real" = "" ]; then
      echo gmco not found
   else
      $real -s `pathToAlias $PWD` $*
   fi
}

function gmlocks ()
{
   local real=`builtin type -all -path gmlocks`
   if [ "$real" = "" ]; then
      echo gmlocks not found
   else
      $real `pathToAlias $PWD` $*
   fi
}

function gmhist ()
{
   local real=`builtin type -all -path gmhist`
   if [ "$real" = "" ]; then
      echo gmhist not found
   else
      $real `pathToAlias $PWD` $*
   fi
}





