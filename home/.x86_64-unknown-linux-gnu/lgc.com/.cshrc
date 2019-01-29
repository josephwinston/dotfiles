# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

# set path = (/home/hb55683/anaconda/bin $path)
# set path = (/opt/local/bin $path)

setenv JAVA_HOME `echo ~/Tools/${FULLNAME}/jdk1.8.0_161`
set path = (${JAVA_HOME}/bin $path)

setenv INTELLIJ_HOME `echo ~/Tools/${FULLNAME}/idea-IC-182.4505.22`
set path = (${INTELLIJ_HOME}/bin $path)

setenv WEBSTORM_HOME `echo ~/Tools/${FULLNAME}/WebStorm-182.4505.50`
set path = (${WEBSTORM_HOME}/bin $path)

#set path = (/opt/gradle-2.10/bin $path)
#set path = (/opt/apache-maven-3.3.3/bin $path)

#
# If you are using gvm, GOPATH might/will change
#

setenv GOPATH `echo ~/src/go`
set path = (/usr/lib/go-1.9/bin $path)
set path = (${GOPATH}/bin $path)

#
# npm
#

set path = (${HOME}/Tools/${FULLNAME}/npm/bin $path)

#
# Zotero
#

set path = (~/Tools/x86_64-unknown-linux-gnu/Zotero_linux-x86_64 $path)

#
# IPFS
#

if ( -e /opt/go-ipfs_v0.4.14/ipfs ) then
    set path = (/opt/go-ipfs_v0.4.14 $path)
endif

#
# Rust
#

if ( -e $HOME/.cargo/bin ) then
    set path = ($HOME/.cargo/bin $path)
endif

#
# snap
#

if ( -e /snap/bin ); then
    set path = (/snap/bin $PATH)
endif
