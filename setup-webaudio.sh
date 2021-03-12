#! /bin/bash

apt update
apt -y install ucspi-tcp gstreamer1.0-tools pulseaudio

sed -i 's/; default-server =\s*$/default-server = unix:\/tmp\/pulseaudio.socket/' /etc/pulse/client.conf
sed -i 's/load-module module-native-protocol-unix\s*/load-module module-native-protocol-unix auth-group=audio socket=\/tmp\/pulseaudio.socket/' /etc/pulse/default.pa

#docker build -t anovnc .
#docker run -d --restart=unless-stopped -p 127.0.0.1:6200:6200 anovnc 
