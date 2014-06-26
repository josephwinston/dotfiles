# /bin/csh -f

#	Use the C Shell

switch ($MACH)

	case sparc:
		set path = ( /hosts/ccsun/usr/data1/FSF/bin )
		set path = ( $path /usr/lang/SC1.0 )
		set path = ( $path /usr/local/purify2.1)
#		set path = ( $path /home/uimx/r250/uimxdir/bin )
		set path = ( $path $X11HOME/bin )
		set path = ( $path /usr/local/bin )
		set path = ( $path /usr/ucb /bin /usr/bin )
		set path = ( $path /usr/5bin /usr/new /usr/kvm)
		set path = ( $path /etc /usr/etc )
		set path = ( $path ~/src/StartraX/installed/bin/SUN4.debug )
#		set path = ( $path /hosts/gmksun/usr/gcsun/CenterLine/clcc/sparc-sunos4/bin)
		# For testcenter
		# set path = ( $path /hosts/jlrsparc/usr/ssm/data3/testcenter/CenterLine/bin)
		# set path = ( $path /hosts/jlrsparc/usr/ssm/data3/testcenter/sparc-sunos4/bin)
	breaksw
	
	case rs6000:
	breaksw
	
	case mips:
	breaksw
	
	default:
		echo "I do not have the architecture '$MACH'"
	breaksw
endsw

