FROM alpine:latest
LABEL maintainer="t@hw.sg"
ARG VNC_TARGET=172.17.0.1:5901 
ARG WEBAUDIO_TARGET=172.17.0.1:6001 

#COPY noVNC/ /usr/share/noVNC/

RUN \
  apk add --no-cache tini git python3 py3-numpy py3-setuptools && \
  git clone --depth 1 https://github.com/novnc/websockify /usr/share/websockify && \
  git clone --depth 1 https://github.com/hw/noVNC.git /usr/share/noVNC && \
  rm -rf /usr/share/noVNC/.git && rm -rf /usr/share/websockify/.git && \
  cd /usr/share/websockify && \
  python3 setup.py install && \
  cd /usr/share/noVNC && \
  cp vnc.html index.html && \
  ln -s /usr/share/noVNC /usr/share/noVNC/novnc && \
  echo novnc: $VNC_TARGET > /etc/websockify.conf && \
  echo audio_novnc: $WEBAUDIO_TARGET >> /etc/websockify.conf && \
  echo Done.

ENV HOME=/root \
    TZ=Asia/Singapore 

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/websockify", "--web", "/usr/share/noVNC", "--token-plugin", "TokenFile", "--token-source", "/etc/websockify.conf"]
CMD ["6200"]
EXPOSE 6200

