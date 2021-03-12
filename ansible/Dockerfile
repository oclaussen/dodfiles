# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo

env:
  PATH: /opt/python/bin

packages:
  name:
    - gettext
    - gnupg
    - openssh-client
    - sshpass
    - zip

download:
  - source: https://github.com/mozilla/sops/releases/download/v3.6.1/sops-v3.6.1.linux
    destination: /bin/sops

from:
  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN pip3 install ansible pywinrm
    path: /opt/python

  - image: dodo/gpg
    path: /home/dodo/.gnupg
