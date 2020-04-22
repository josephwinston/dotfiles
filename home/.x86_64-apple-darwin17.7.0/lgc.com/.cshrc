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
# set path = ($path /opt/local/libexec/qt4/bin)

#
# npm
#

# set path = ($path ~/node_modules/.bin)
set path = (${HOME}/Tools/${FULLNAME}/npm/bin $path)
set path = (${HOME}/.cargo/bin $path)

