FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get -y install \
    automake \
    flex \
    libtool \
    pkg-config \
    swig \
    libpcsclite-dev \
    libusb-1.0.0-dev

RUN git clone https://salsa.debian.org/rousseau/pcsc.git /pcsc
WORKDIR /pcsc
RUN ./bootstrap \
 && ./configure \
        --prefix=/opt/pcsc \
        --enable-libusb \
        --disable-libsystemd \
        --disable-libudev \
 && make \
 && make install

RUN git clone --recursive https://salsa.debian.org/rousseau/ccid.git /ccid
WORKDIR /ccid
RUN ./bootstrap \
 && ./configure \
        --enable-usbdropdir=/opt/pcsc/lib/pcsc/drivers \
 && make \
 && make install

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH
RUN pip install pyscard yubikey-manager

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        libccid \
        scdaemon \
        gnupg \
        libncurses6 \
        libpcsclite1 \
        pinentry-curses \
        procps \
        usbutils

COPY --from=build /opt/pcsc /opt/pcsc
ENV PATH /opt/pcsc/bin:/opt/pcsc/sbin:$PATH

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY root/ /

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
RUN chmod 700 /home/dodo/.gnupg

RUN for file in $(ls /home/dodo/.gnupg/keys/0x*.txt); do gpg --import "${file}"; done
RUN for key in $(cat "/home/dodo/.gnupg/keys/trustlist.txt" | grep -v '^#'); do echo $key | gpg --import-ownertrust; done
RUN sockets="S.gpg-agent S.gpg-agent.browser S.gpg-agent.extra S.gpg-agent.ssh S.gpg-agent.ssh S.scdaemon"; \
    for s in ${sockets}; do rm -f "/home/dodo/.gnupg/${s}"; printf "%%Assuan%%\nsocket=/data/gpg-agent/${s}\n" > "/home/dodo/.gnupg/${s}"; done
