#!/bin/bash

mkdir -p /root/.vnc/
touch /root/.Xauthority
vncpasswd -f <<< $PASSWORD > /root/.vnc/passwd
rm -rf /root/.vnc/*.pid /root/.vnc/*.log /tmp/.X1* /run/dbus/pid
vncserver -PasswordFile /root/.vnc/passwd
(echo "$PASSWORD" && echo "$PASSWORD") | passwd 2> /dev/null
dbus-daemon --config-file=/usr/share/dbus-1/system.conf
sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js
touch /usr/share/novnc/index.htm
/usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc 127.0.0.1:5901