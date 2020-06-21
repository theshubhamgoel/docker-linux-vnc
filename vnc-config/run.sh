#!/bin/bash

mv ~/.vnc/xstartup ~/.vnc/xstartup.bak
#echo $'#!/bin/bash \nxrdb $HOME/.Xresources \nstartxfce4 &' > ~/.vnc/xstartup
echo $'#!/bin/bash \n[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup \n[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources \nvncconfig -iconic & \ndbus-launch --exit-with-session gnome-session &' > ~/.vnc/xstartup

cat ~/.vnc/xstartup
chmod +x ~/.vnc/xstartup

#vncserver -localhost -depth 32 -geometry 1680x1050 -SecurityTypes None
vncserver -localhost -depth 32 -geometry 1280×720

ss -tulpn | egrep -i 'vnc|590'
echo "DONE"

tail -f ~/.vnc/*.log
#tail -f /dev/null

