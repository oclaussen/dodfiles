# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

env:
  PATH: /opt/python/bin:/home/dodo/bin

packages:
  name:
    - curl
    - gcal
    - libsqlite3-0
    - procps

from:
  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN pip3 install khal
    path: /opt/python
  - image: dodo/khal
    path: /home/dodo/.config/khal

run:
  - script: |
      cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime
      echo Europe/Berlin > /etc/timezone
