FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y

RUN apt install htop xfce4 xfce4-goodies xfonts-base -y

RUN apt tightvncserver tigervnc-standalone-server tigervnc-xorg-extension tigervnc-viewer -y

CMD tail -f /dev/null

