#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
	xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# set background color and cursor
# xsetroot -solid "#333333"
#xsetroot -cursor_name left_ptr

# lock screen setup
lockercmd="env XSECURELOCK_BLANK_DPMS_STATE=off XSECURELOCK_BLANK_TIMEOUT=3 xsecurelock"
xss-lock -n /usr/lib/xsecurelock/dimmer -l -- $lockercmd &

# blank screen after 5 minutes
xset s 300 300

exec i3
