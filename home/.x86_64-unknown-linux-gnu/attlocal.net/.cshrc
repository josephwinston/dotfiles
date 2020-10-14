# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

#
# If you are using gvm, GOPATH might/will change
#

#setenv GOPATH `echo ~/src/go`
#set path = (${GOPATH}/bin $path)

#
# Rust
#

if ( -e $HOME/.cargo/bin ) then
    set path = ($HOME/.cargo/bin $path)
endif

