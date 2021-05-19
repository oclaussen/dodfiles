# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

env:
  PATH: /opt/pcsc/bin:/opt/pcsc/sbin:/opt/python/bin:/home/dodo/bin

packages:
  name:
    - libccid
    - scdaemon
    - gnupg
    - libncurses6
    - libpcsclite1
    - pinentry-tty
    - procps
    - usbutils

from:
  - dockerfile: |
      FROM dodo/languages/buildbase AS build
      
      RUN apt-get update \
       && apt-get -y install \
          automake \
          flex \
          libtool \
          pkg-config \
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
    path: /opt/pcsc

  - dockerfile: |
      FROM dodo/languages/python

      RUN apt-get update \
       && apt-get -y install \
          build-essential \
          libpcsclite-dev \
          swig

      ENV PATH /opt/python/bin:$PATH
      RUN pip install pyscard yubikey-manager
    path: /opt/python

run:
  - user: dodo
    cwd: /home/dodo/.gnupg
    script: |
      set -eux
      for file in $(ls keys/0x*.txt); do gpg --import "${file}"; done
      for key in $(cat "keys/trustlist.txt" | grep -v '^#'); do echo $key | gpg --import-ownertrust; done
      sockets="S.gpg-agent S.gpg-agent.browser S.gpg-agent.extra S.gpg-agent.ssh S.gpg-agent.ssh S.scdaemon"; \
      for s in ${sockets}; do rm -f "${s}"; printf "%%%%Assuan%%%%\nsocket=/data/gpg-agent/${s}\n" > "${s}"; done
