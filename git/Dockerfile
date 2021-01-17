# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

packages:
  name:
    - git
    - git-lfs
    - openssh-client
    - less
    - vim

download:
  - source: https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz
    unpack: hub-linux-amd64-2.14.2/bin/hub
    destination: /bin/hub

  - source: https://github.com/zaquestion/lab/releases/download/v0.17.2/lab_0.17.2_linux_amd64.tar.gz
    unpack: lab
    destination: /bin/lab

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
