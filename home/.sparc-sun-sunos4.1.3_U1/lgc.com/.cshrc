# /bin/csh -f

#
# Use the C Shell
#

set path = ( /usr/local/bin )
set path = ( $path /usr/local/etc )
set path = ( $path $X11HOME/bin )
set path = ( $path $OPENWINHOME/bin )
set path = ( $path /usr/games )
set path = ( $path /usr/ucb /bin /usr/bin )
set path = ( $path /usr/5bin /usr/new /usr/kvm)
set path = ( $path /etc /usr/etc )

set path = ( $path $FMHOME/bin)
set path = ( $path /d/gm/sharebin )

if ($?prompt != 0) then
  if ($prompt != "") then
    #For the type 5 keyboard
    stty erase '^H'
  endif
endif


