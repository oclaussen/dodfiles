FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        pcscd \
        libccid \
        scdaemon \
        gnupg \
        libncurses6 \
        pinentry-curses

COPY init /init
USER dodo
