#!/bin/bash

if [ ! -d ~/.vnc/ ]; then
    mkdir -p ~/.vnc/
fi
if [ ! -f ~/.Xauthority ]; then
    touch ~/.Xauthority
fi
rm -rf ~/.vnc/*.pid ~/.vnc/*.log /tmp/.X1*
(echo "${PASSWORD}"; echo "${PASSWORD}") | passwd > /dev/null 2>&1
vncpasswd -f <<< ${PASSWORD} > ~/.vnc/passwd
vncserver -PasswordFile ~/.vnc/passwd
dbus-daemon --config-file=/usr/share/dbus-1/system.conf
/usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc 127.0.0.1:5901
