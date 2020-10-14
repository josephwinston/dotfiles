#
# $Id: //depot/Jody/main/jody/.i686-unknown-linux/xprtcc.com/.bashrc#3 $
#

#
# This is a little like `zap' from Kernighan and Pike
#

zap()
{
   local pid
   
   pid=$(ps ax | grep $1 | grep -v grep | awk '{ print $1 }')
      if [ ! "$pid" = "" ]; then
	 echo -n "killing $1 (process $pid) ... "
	 kill -9 $pid
	 echo "done."
      fi
}


total()
{
   ls -l |gawk 'BEGIN{tot = 0;num = 0} \
    {tot += $5; num++} \
    END{printf("%d bytes in %d files\n", tot, num)}'
}

alias ls "ls -C --color=auto"

alias versions "rpm -q -a --queryformat '%{NAME} %{VERSION}\n'"

# alias from "frm"

if [ -f $HOME/src/Remote/GIT/git/contrib/completion/git-completion.bash ]; then
    . $HOME/src/Remote/GIT/git/contrib/completion/git-completion.bash
fi

#
# Open functionality
#

alias open "xdg-open"

#
# aqt see source setQtVersion 
#

#
# Homesick
#

source "$HOME/.homesick/repos/homeshick/homeshick.sh"

#
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#
# gvm
#

[[ -s "/home/josephwinston/.gvm/scripts/gvm" ]] && source "/home/josephwinston/.gvm/scripts/gvm"

#if [ -s "/home/josephwinston/.gvm/scripts/gvm" ]; then
#    gvm use system > /dev/null 2>&1 
#fi

if [ -e /home/josephwinston/anaconda3/etc/profile.d/conda.sh ]; then
    source /home/josephwinston/anaconda3/etc/profile.d/conda.sh
fi

# conda initialize
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/josephwinston/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/josephwinston/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/josephwinston/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/josephwinston/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

#
# nvm
#

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
# Vulkan
# __NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only %command%
#

#
# OpenGL
# __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia nvidia-smi
#

#
# Here is what prime_run uses
#
# __NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
#

#
# Using the compilers
#

# unsetenv LD_LIBRARY_PATH
# source /opt/oecore-x86_64/environment-setup-armv7at2hf-neon-oe-linux-gnueabi
# cmake -DMACHINE=cms-switch ..


