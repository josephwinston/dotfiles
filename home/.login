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



set path=( $path "/Users/hb55683/NVPACK/android-sdk-macosx/platform-tools" )

set path=( $path "/Users/hb55683/NVPACK/android-sdk-macosx/build-tools" )

set path=( $path "/Users/hb55683/NVPACK/android-sdk-macosx/tools" )

setenv NDK_ROOT "/Users/hb55683/NVPACK/android-ndk-r9c"





set path=( $path "/Users/hb55683/NVPACK/apache-ant-1.8.2/bin" )
