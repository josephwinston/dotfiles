# /bin/csh -f

#
# $Id: //depot/Jody/main/jody/.sparc-sun-sunos4.1.3_U1/xprt.com/.cshrc#1 $
#

#
# Use the C Shell
#

set path = ( /usr/local/XEMACS-19.14/bin/sparc-sun-sunos4.1.3 )
set path = ( $path /usr/local/bin )
set path = ( $path /usr/local/PURE/bin )
set path = ( $path /usr/local/etc )
set path = ( $path /usr/local/ilu/bin )
set path = ( $path /usr/AcroRead/bin )
set path = ( $path $X11HOME/bin )
set path = ( $path /usr/visual/bin )
set path = ( $path /usr/elk/bin )
set path = ( $path /usr/openwin/bin )
set path = ( $path /usr/games )
set path = ( $path /usr/ucb /bin /usr/bin )
set path = ( $path /usr/5bin /usr/new /usr/kvm)
set path = ( $path /etc /usr/etc )

if ($?prompt != 0) then
  if ($prompt != "") then
    # Only set if interactive
    # For the type 5 keyboard
    stty erase '^H'
  endif
endif


