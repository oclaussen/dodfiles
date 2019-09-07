FROM bitnami/minideb:buster

RUN apt-get -y update \
 && apt-get -y install \
        tmux \
        zsh

RUN addgroup \
      --gid 1000 \
      oclaussen \
 && adduser \
      --uid 1000 \
      --gid 1000 \
      --gecos ''\
      --home /home/oclaussen \
      --disabled-password \
      oclaussen

RUN mkdir -p /data/tmux /data/zsh \
 && chown oclaussen:oclaussen /data/tmux /data/zsh

COPY session.sh /session.sh

USER oclaussen
COPY tmux.conf /home/oclaussen/.tmux.conf
COPY zshrc /home/oclaussen/.zshrc
