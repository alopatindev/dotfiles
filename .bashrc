# /etc/skel/.bashrc:
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]]; then
	eval `dircolors -b ~/.dir_colors`
else
	eval `dircolors -b /etc/DIR_COLORS`
fi

# Change the window title of X terminals 
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\033\\"'
		;;
esac

if [[ -f /usr/share/mc/mc.gentoo ]]; then
	. /usr/share/mc/mc.gentoo
fi

PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '

if [[ $CHROOTEN -eq 1 ]]; then
    PS1="(chroot 32bit) ${PS1}"
fi

SAL_USE_VCLPLUGIN=gtk

function setdsm() {
    # add the current directory and the parent directory to PYTHONPATH
    # sets DJANGO_SETTINGS_MODULE
    export PYTHONPATH=$PYTHONPATH:$PWD/..
    export PYTHONPATH=$PYTHONPATH:$PWD
    if [ -z "$1" ]; then 
        x=${PWD/\/[^\/]*\/}
        export DJANGO_SETTINGS_MODULE=$x.settings
    else    
        export DJANGO_SETTINGS_MODULE=$1
    fi

    echo "DJANGO_SETTINGS_MODULE set to $DJANGO_SETTINGS_MODULE"
}

#export MAKEDICT_PLUGIN_DIR=/usr/share/makedict/codecs
export PATH="${HOME}/.bin:${PATH}"
export OLDPWD=~
export BROWSER=chromium
#export TERM=rxvt-unicode
#export DISPLAY=:0

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Xms256m -Xmx512m -XX:MaxHeapSize=256m'
export ANDROID_NDK='/opt/android-ndk/'

export EDITOR=vim

source ~/.bash_completes
source ~/.bash_alias
