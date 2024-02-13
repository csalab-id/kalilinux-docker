#!/bin/bash

mkdir -p ~/.vnc/
rm -rf ~/.vnc/*.pid ~/.vnc/*.log /tmp/.X1*
touch ~/.Xauthority
vncpasswd -f <<< $PASSWORD > ~/.vnc/passwd
vncserver -PasswordFile ~/.vnc/passwd
sudo dbus-daemon --config-file=/usr/share/dbus-1/system.conf
/usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc 127.0.0.1:5901