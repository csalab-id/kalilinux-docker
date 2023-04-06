#!/bin/bash

rm -rf /root/.vnc/*.pid /root/.vnc/*.log /tmp/.X1* /run/dbus/pid
mkdir -p /root/.vnc/
touch /root/.Xauthority
vncpasswd -f <<< $VNC_PASSWORD > /root/.vnc/passwd
vncserver -PasswordFile /root/.vnc/passwd
(echo "$VNC_PASSWORD" && echo "$VNC_PASSWORD") | passwd 2> /dev/null
dbus-daemon --config-file=/usr/share/dbus-1/system.conf
sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js
/usr/share/novnc/utils/novnc_proxy --listen 80 --vnc 127.0.0.1:5901