# /bin/csh -f

#
# $Id: .login,v 1.1 2000/10/13 13:57:18 CVS_jody Exp $
#

# skip remaining setup if not an interactive shell 

# if a spawned task, exit
if ($?prompt == 0) then
  exit
endif

source ~/.setenv
# echo done source ~/.setenv
