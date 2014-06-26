# /bin/csh -f

#	Use the C Shell

switch ($MACH)
	case sparc:
		if ($FULLNAME != "sparc-sun-solaris2.4") then
			set path = ( ~jjpersch/pkg/xemacs/bin/sparc-sunos4 )
			set path = ( $path ~jjpersch/pkg/gcc/sparc-sunos4/bin )
			set path = ( $path /usr/local /usr/local/bin /usr/local/etc )
			set path = ( $path /usr/local/apps/bin )
#			set path = ( $path ~spirit2/APPL/usr/SunOS/bin )
			set path = ( $path ~spirit2/PURIFY-3.0/SunOS )
			set path = ( $path ~spirit2/QUANTIFY-2.0/SunOS )
			set path = ( $path /usr/local/ir/software/pure/SunOS )
			set path = ( $path /usr/shell )
			set path = ( $path /usr/bin/X11 )
#			set path = ( $path $X11HOME/bin )
			set path = ( $path $OPENWINHOME/bin )
			set path = ( $path /usr/games )
			set path = ( $path $LANG_HOME )
			set path = ( $path $LANG_HOME/C++_2.1 $LANG_HOME/SW2.0.1/bin )
			set path = ( $path ~gclib/bin/gnu ~gclib/bin/sun4 )

			set path = ( $path /usr/ucb /bin /usr/bin )
			set path = ( $path /usr/5bin /usr/new /usr/kvm )
			set path = ( $path /etc /usr/etc )
		else
			set path = ( /usr/sbin )
			set path = ( $path /usr/bin )
			set path = ( $path /usr/ccs/bin )
			set path = ( $path /etc /usr/etc )

		endif

		if ($?prompt != 0) then
			if ($prompt != "") then
#				For the type 5 keyboard
				stty erase '^H'
			endif
		endif

	breaksw

	case mips:
	breaksw
	
	default:
		echo "I do not have the architecture '$MACH'"
	breaksw
endsw

