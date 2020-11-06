# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash_history ]; then
   chmod 600 ~/.bash_history
fi

# for read permissions
umask 022

# Setenv stuff

if [ "$PS1" ]; then
    # Interactive stuf only
    if [ $TERM = "emacs" ]; then
	PS1='\h:\w> '
    else
	if [ `whoami` != "root" ]; then
	    PS1='\h:\w '
	else
	    PS1='\h:\w# '
	fi
	if [ `tty` != "/dev/ttya" -o `tty` != "/dev/ttyb" ]; then
	    # allow the use of the meta key and turn of ^S
	    stty -istrip -parenb cs8 -ixon intr "^C" susp ^Z
	fi
    fi
    if [ "$CLEARCASE_ROOT" ]; then
	PS1="[`basename $CLEARCASE_ROOT`] $PS1"
    fi
fi


# Here are a couple of functions to make csh user's lives easier.
function setenv () 
{
   export $1="$2"
}

function unsetenv () 
{
   unset $*
}

function alias () 
{
   local name=$1
   shift
   local value="$*"
   if [ "$name" = "" ]; then
      builtin alias
   elif [ "$value" = "" ]; then
      builtin alias $name
   else
      builtin alias $name="$value"
   fi
}

alias ls ls -C
alias pwd echo \$PWD
alias whereis whatis
alias which whatis

#
# whatis -- and implementation of the 10th Edition Unix sh builtin `whatis'
#	    command.
#
# usage: whatis arg [...]
#
# For each argument, whatis prints the associated value as a parameter,
# builtin, function, alias, or executable file as appropriate.  In each
# case, the value is printed in a form which would yield the same value
# if typed as input to the shell itself.
#

whatis()
{
	local wusage='usage: whatis arg [arg...]'
	local fail=0
	
	if [ $# -eq 0 ] ; then
		echo "$wusage"
		return 1
	fi
	
	for arg
	do
		case $(builtin type -type $arg) in
		"alias")
			echo "$(alias $arg)"
			;;
		"function")
			builtin type "$arg" | sed 1d
			;;
		"builtin")
			echo builtin "$arg"
			;;
		"file")
			echo $(type -path "$arg")
			;;
		*)
			# OK, we could have a variable, or we could have nada
			if [ "$(eval echo \${$arg+set})" = "set" ] ; then
				# It is a variable, and it is set
				echo -n "$arg="
				eval echo \$$arg
			else
				fail=1
			fi
			;;
		esac
	done
	return $fail
}

# "repeat" command.  Like:
#
#	repeat 10 echo foo
repeat ()
{ 
   local count="$1" i;
   shift;
   for i in $(seq 1 "$count");
   do
      eval "$@";
   done
}

# Subfunction needed by `repeat'.
seq ()
{ 
   local lower upper output;
   lower=$1 upper=$2;
   while [ $lower -le $upper ];
   do
      output="$output $lower";
      lower=$[ $lower + 1 ];
   done;
   echo $output
}

#
# History
#

HISTORYCONTROL=ignoredups
history_control=ignoredups
command_oriented_history=1
histappend=1
HISTSIZE=5000
HISTFILESIZE=50000

if [ "$FULLNAME" ]; then
    if [ -f $HOME/.$FULLNAME/$DOMAIN/.bashrc ]; then
	source $HOME/.$FULLNAME/$DOMAIN/.bashrc
    fi
fi

# set the prompt

# cd
