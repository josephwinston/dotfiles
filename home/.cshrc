# /bin/csh -f

# echo "~/.cshrc"

#
# $Id: .cshrc,v 1.1 2000/09/05 00:13:27 CVS_jody Exp $
#

#
# Use the C Shell
#

# large values of history are better
set history = 500
# set savehist = 50

# Default file and directory creations are to set permissions
# for owner only
# umask 077
# for read permissions
umask 022

#
# .setenv is needed for remote login
# see if MACH exists, if not source .setenv
#

if ($?MACH_XXX == 0) then
  source ~/.setenv
endif

#
# load the correct domain information
#

if ( -e ~/.$FULLNAME/$DOMAIN/.cshrc ) then
  source ~/.$FULLNAME/$DOMAIN/.cshrc
  # echo done source ~/.$FULLNAME/$DOMAIN/.cshrc
else
  echo ~/.$FULLNAME/$DOMAIN/.cshrc not found
endif

#
# Architecture independent code
#

set path = ( ~/Tools/bin $path )

#
# Domain specific architecture independent code
#

set path = ( ~/Tools/bin/$DOMAIN $path )
set path = ( ~/Tools/bin/$DOMAIN/machines $path )

#
# architecture specific code
#

# set path = ( ~/Tools/bin/$FULLNAME $path )

set path = ( ~/Tools/$FULLNAME/bin $path )

#
# N32 hack
#

# set path = ( ~/Tools/${FULLNAME}n32/bin $path )

#
# set at the very last the current directory
#

set path = ( $path . )

#
# skip remaining setup if not an interactive shell
#

if (($?LOGNAME == 0) && ($UNAME_SYSTEM == "SYSV")) then
  exit
endif

if ($?USER == 0) then
  setenv USER `echo $LOGNAME`
endif

if ($?prompt == 0) then
  exit
endif

#
# Hack for sparc
#

#if ($?prompt != 0) then
#  if (($MACH == "sparc") && ($prompt == "")) then
#    exit	
#  endif
#endif

#
# cdpath to get to things in my home, text dirs or other
# users' dirs quickly.
#

set cdpath = ( ~ ~/..)

source ~/.alias
# echo done source ~/.alias

#
#	turn on the prompt
#

setprompt

#
#	Set the prompt
#

# cd

unset noclobber
#set fignore = (.o .out)
set filec

#
# Turn messages off
#

mesg n

#
# load the correct domain information
#

if ( -e ~/.$FULLNAME/$DOMAIN/.startup ) then
  source ~/.$FULLNAME/$DOMAIN/.startup
  # echo done source ~/.$FULLNAME/$DOMAIN/.startup
endif
