# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

setenv SCALA_HOME ${HOME}/Tools/typesafe-stack

set path = (/usr/bin/X11 $path)
set path = (/opt/local/bin $path)
set path = (${JAVA_HOME}/bin $path)
set path = (${SCALA_HOME}/bin $path)


