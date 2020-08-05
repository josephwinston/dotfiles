# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

# set path = (/home/hb55683/anaconda/bin $path)
# set path = (/opt/local/bin $path)

# setenv JAVA_HOME `echo ~/Tools/${FULLNAME}/jdk1.8.0_161`
# set path = (${JAVA_HOME}/bin $path)

# setenv DATA_GRIP_HOME `echo ~/Tools/${FULLNAME}/DataGrip`
# set path = (${DATA_GRIP_HOME}/bin $path)
 
# setenv ZOTERO_HOME `echo ~/Tools/${FULLNAME}/Zotero`
# set path = (${ZOTERO_HOME}/bin $path)

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
# IPFS
#

#
# Rust
#

if ( -e $HOME/.cargo/bin ) then
    set path = ($HOME/.cargo/bin $path)
endif

