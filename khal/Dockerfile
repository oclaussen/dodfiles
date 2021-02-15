# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

env:
  PATH: /opt/python/bin

packages:
  name:
    - cron
    - libsqlite3-0
    - vim

from:
  - directory: root
    path: /

  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN pip3 install khal vdirsyncer requests-oauthlib
    path: /opt/python

run:
  - script: chmod u+s /usr/sbin/cron
  - script: |
      cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime
      echo Europe/Berlin > /etc/timezone
