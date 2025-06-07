FROM kalilinux/kali-rolling:latest
LABEL maintainer="admin@csalab.id"
RUN sed -i "s/http.kali.org/mirrors.ocf.berkeley.edu/g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    sudo \
    openssh-server \
    python2 \
    python3-pip \
    python3-virtualenv \
    dialog \
    firefox-esr \
    inetutils-ping \
    htop \
    nano \
    net-tools \
    tigervnc-standalone-server \
    tigervnc-xorg-extension \
    tigervnc-viewer \
    novnc \
    dbus-x11
RUN DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    xfce4-goodies \
    kali-desktop-xfce && \
    apt-get -y full-upgrade
RUN apt-get -y autoremove && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -c "Kali Linux" -s /bin/bash -d /home/kali kali && \
    sed -i "s/#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config && \
    sed -i "s/off/remote/g" /usr/share/novnc/app/ui.js && \
    echo "kali ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    mkdir /run/dbus && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    touch /usr/share/novnc/index.htm
COPY startup.sh /startup.sh
USER kali
WORKDIR /home/kali
RUN mkdir -p /home/kali/.config && \
    virtualenv /home/kali/.config/app && \
    echo "source /home/kali/.config/app/bin/activate" >> /home/kali/.bashrc
ENV PASSWORD=kalilinux
ENV SHELL=/bin/bash
EXPOSE 8080
ENTRYPOINT ["/bin/bash", "/startup.sh"]
