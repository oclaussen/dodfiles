FROM bitnami/minideb:buster

RUN apt-get -y update \
 && apt-get -y install \
        tmux \
        zsh

COPY server.sh /server.sh
