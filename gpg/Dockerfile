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
        procps

COPY --from=build /opt/pcsc /opt/pcsc
ENV PATH /opt/pcsc/bin:/opt/pcsc/sbin:$PATH

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY init /init
USER dodo
