# /bin/csh -f

#
# Use the C Shell
#

set path = (/usr/local/bin)
set path = ($path /sbin)
set path = ($path /usr/bin)
set path = ($path /bin)
set path = ($path /usr/X11R6/bin)
set path = ($path /usr/sbin)

if ($?prompt != 0) then
    # Only set if interactive
    stty erase "^H"
endif


