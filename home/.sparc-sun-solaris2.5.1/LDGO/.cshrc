# /bin/csh -f

#
# $Id: //depot/Jody/main/jody/.sparc-sun-solaris2.5.1/LDGO/.cshrc#1 $
#

#
# Use the C Shell
#

set path = (/usr/sbin)
set path = ($path /usr/bin)
set path = ($path /bin)
set path = ($path /etc)
set path = ($path /usr/local/SUNWspro/bin)
set path = ($path /usr/ccs/bin)
set path = ($path /usr/xpg4/bin)
set path = ($path /usr/etc)
set path = ($path /usr/openwin/bin)
set path = ($path /usr/local/bin)
set path = ($path /usr/ucb)

if ($?prompt != 0) then
  if ($prompt != "") then
    # Only set if interactive
    stty intr "^C" echoe
  endif
endif

# Set the TERM environment variable

# if ( -d /usr/lib/terminfo ) then
#    eval `tset -s -Q`
# endif

