# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

set path = (/opt/local/bin $path)
