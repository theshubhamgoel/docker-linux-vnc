FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y

RUN apt install htop xfce4 xfce4-goodies xfonts-base -y
RUN apt install tigervnc-common tigervnc-scraping-server tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer -y

RUN apt install build-essential libncurses5-dev libncursesw5-dev -y
RUN apt install git vim -y

#Add default user account
ARG UID=1000
ARG USER=default
RUN useradd ${USER} -u ${UID} -U -d /home/${USER} -m -s /bin/bash
RUN usermod -aG sudo default

#USER default
WORKDIR /root

COPY vnc-config /root/workspace/vnc-config
ADD vnc-config/xstartup /root/.vnc/
RUN chmod +x ~/.vnc/xstartup

CMD tail -f /dev/null

