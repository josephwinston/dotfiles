# /bin/csh -f

if ($?prompt != 0) then
   # Only set if interactive
   stty erase "^?" 
endif

# set path = (/home/hb55683/anaconda/bin $path)
set path = (/opt/local/bin $path)

#setenv JAVA_HOME `echo ~/Tools/${FULLNAME}/jdk1.8.0_66`
#set path = (${JAVA_HOME}/bin $path)
#set path = (/opt/gradle-2.10/bin $path)
#set path = (/opt/apache-maven-3.3.3/bin $path)

