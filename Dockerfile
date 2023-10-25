FROM kalilinux/kali-rolling:amd64
LABEL maintainer="admin@csalab.id"
WORKDIR /root
RUN apt update && \
apt -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt -yq install \
  dialog \
  firefox-esr \
  inetutils-ping \
  htop \
  nano \
  net-tools \
  tigervnc-standalone-server \
  tigervnc-xorg-extension \
  tigervnc-viewer \
  novnc
RUN DEBIAN_FRONTEND=noninteractive apt -yq install \
  dbus-x11 \
  xfce4-session \
  xfce4-goodies \
  kali-linux-large \
  kali-desktop-xfce
RUN apt -y dist-upgrade && \
apt -y autoremove && \
apt clean all
COPY startup.sh /startup.sh
ENV PASSWORD=kalilinux
ENV SHELL=/bin/bash
EXPOSE 8080
ENTRYPOINT ["/bin/bash", "/startup.sh"]