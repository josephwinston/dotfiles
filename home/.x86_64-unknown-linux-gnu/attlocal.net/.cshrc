<<# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

# set path = (/home/hb55683/anaconda/bin $path)
# set path = (/opt/local/bin $path)

#
# If you are using gvm, GOPATH might/will change
#

setenv GOPATH `echo ~/src/go`
# set path = (/usr/lib/go-1.9/bin $path)
set path = (${GOPATH}/bin $path)

#
# npm
#

# set path = (${HOME}/Tools/${FULLNAME}/npm/bin $path)

#
# Rust
#

if ( -e $HOME/.cargo/bin ) then
    set path = ($HOME/.cargo/bin $path)
endif

