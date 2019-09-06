FROM bitnami/minideb:buster

RUN apt-get -y update \
 && apt-get -y install \
        git \
        git-lfs

COPY gitconfig /root/.gitconfig
