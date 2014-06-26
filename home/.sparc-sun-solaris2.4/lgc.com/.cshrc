# /bin/csh -f

#
# Use the C Shell
#

set path = ( /usr/local/bin )
set path = ( $path /usr/local/etc )
set path = ( $path $X11HOME/bin )
set path = ( $path $OPENWINHOME/bin )
set path = ( $path /usr/games )
set path = ( $path /usr/ccs/bin )
set path = ( $path /bin /usr/bin )
set path = ( $path /usr/kvm)
set path = ( $path /etc /usr/etc )
set path = ( $path /usr/ucb )

if ($?prompt != 0) then
  if ($prompt != "") then
    #For the type 5 keyboard
    stty erase '^H'
  endif
endif


