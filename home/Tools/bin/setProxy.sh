#! /bin/sh

#
# In Mac OS X, what network location is set?
#

if [ -f "/usr/sbin/scselect" ]; then
    export LOCATION=$(/usr/sbin/scselect 2>&1 | perl -ne 'if (m/^\s+\*\s+(\S+)\s+\((.+)\)$/) { print "$2\n"; }')
fi

case ${LOCATION} in
    "Home")
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Home/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Home/settings.xml ${HOME}/.m2/settings.xml
	cp ${HOME}/.network/Home/.gitconfig ${HOME}/.gitconfig
	;;
    "Halliburton")
#	PROXY=houprxy801.corp.halliburton.com
#	PROXY=np1prxy801.corp.halliburton.com
#       PORT=80
	PROXY=127.0.0.1
        PORT=3128
	export http_proxy=http://${PROXY}:${PORT}
	export https_proxy=http://${PROXY}:${PORT}
	export ftp_proxy=http://${PROXY}:${PORT}
	export no_proxy="localhost, *.lgc.com, *.houston.lgc.com, *.corp.halliburton.com, *.dev, 127.0.0.*, 10.*, 192.168.*, .sock"
	export RSYNC_PROXY=${PROXY}:${PORT}
	cp ${HOME}/.subversion/Halliburton/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Halliburton/settings.xml ${HOME}/.m2/settings.xml
	cp ${HOME}/.network/Halliburton/.gitconfig ${HOME}/.gitconfig
	;;
    "Automatic")
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Automatic/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Automatic/settings.xml ${HOME}/.m2/settings.xml
	cp ${HOME}/.network/Automatic/.gitconfig ${HOME}/.gitconfig
	;;
    *)
	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset RSYNC_PROXY
	cp ${HOME}/.subversion/Automatic/servers ${HOME}/.subversion/servers
	cp ${HOME}/.m2/Automatic/settings.xml ${HOME}/.m2/settings.xml
	;;
esac

