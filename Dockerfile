FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y

RUN apt install htop xfce4 xfce4-goodies xfonts-base -y
RUN apt install ubuntu-gnome-desktop -y
RUN systemctl enable gdm

RUN apt install tigervnc-common tigervnc-scraping-server tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer -y

RUN apt install build-essential libncurses5-dev libncursesw5-dev -y
RUN apt install vim git iproute2 net-tools -y

# Install locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales && \
    echo "$LANG UTF-8" >> /etc/locale.gen && \
    locale-gen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install systemd
RUN apt-get update && apt-get install -y \
    dbus dbus-x11 systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* &&\
    dpkg-divert --local --rename --add /sbin/udevadm &&\
    ln -s /bin/true /sbin/udevadm

RUN apt install -y --no-install-recommends gnome-session gnome-terminal

#Add default user account
ARG UID=1000
ARG USER=default
RUN useradd ${USER} -u ${UID} -U -d /home/${USER} -m -s /bin/bash
RUN usermod -aG sudo default

#USER default
WORKDIR /root

COPY ./vnc-config/xstartup /root/.vnc/xstartup
RUN cat /root/.vnc/xstartup
COPY ./vnc-config/run.sh /root/workspace/run.sh

RUN printf "123456\n123456\n\n" | vncpasswd

CMD /bin/bash -c /root/workspace/run.sh
