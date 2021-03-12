#! /bin/bash

pulseaudio -k && pulseaudio -D
tcpserver 172.17.0.1 6001 gst-launch-1.0 -q pulsesrc server=/tmp/pulseaudio.socket ! audio/x-raw, channels=2, rate=24000 ! cutter ! opusenc ! webmmux ! fdsink fd=1

