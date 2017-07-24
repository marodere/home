# /etc/skel/.bashrc
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

chps1() {
	export PS1=$(sed -e 's/\\[uh]/marodere/g' <<< "${PS1}")
}


# Put your fun stuff here.

xbmc-getscreens () {
	rsync -av --rsh=ssh master:/place/kodi/screenshot/ $HOME/xbmcscreenshot/
	( cd $HOME/xbmcscreenshot/ ; gwenview "$(ls | tail -n 1)" ) &> /dev/null &
}

export HISTFILESIZE=65535
export HISTSIZE=65535

gp6() {
	( cd $HOME/distrib/gp6/opt/GuitarPro6 ; ./GuitarPro ) &> /dev/null &
	"$HOME/distrib/Guitar Pro 6/Crack/Linux/keygen_linux"
}

SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
