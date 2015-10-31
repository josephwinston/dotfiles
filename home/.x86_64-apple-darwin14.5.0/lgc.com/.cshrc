# /bin/csh -f

#
# $Id: .cshrc,v 1.1 2004/08/09 23:13:08 CVS_jody Exp $
#

#
# Use the C Shell
#

set path = ($path /usr/X11/bin)
set path = ($path /usr/texbin)

#
# Macports
#

set path = (/opt/local/bin $path)
set path = (/opt/local/sbin $path)
set path = (/opt/local/libexec/qt4/bin $path)

#
# npm
#

set path = ($path ~/node_modules/.bin)

#
# Ruby
#

# set path = ($path ~/.gem/ruby/2.0.0/bin)

#
# GO
#

set path = ($path ~/src/Languages/GO/bin)

#
# iterm integration
#

# test -e ${HOME}/.iterm2_shell_integration.tcsh && source ${HOME}/.iterm2_shell_integration.tcsh

