if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -f /usr/bin/i3 ]; then
    dbus-update-activation-environment --systemd DISPLAY
    exec i3
fi
