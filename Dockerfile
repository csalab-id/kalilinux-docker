FROM kalilinux/kali-rolling:latest
LABEL maintainer="admin@csalab.id"
RUN sed -i "s/http.kali.org/mirrors.ocf.berkeley.edu/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    burpsuite \
    dialog \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    novnc \
    dbus-x11 \
    openbox && \
    apt-get -y full-upgrade
RUN apt-get -y autoremove && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -c "Kali Linux" -s /bin/bash -d /home/kali kali && \
    sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js && \
    touch /usr/share/novnc/index.htm
COPY startup.sh /startup.sh
USER kali
WORKDIR /home/kali
ENV VNC_PASSWORD=burpsuite
ENV SHELL=/bin/bash
EXPOSE 6080
ENTRYPOINT ["/bin/bash", "/startup.sh"]
