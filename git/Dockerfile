# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

packages:
  name:
    - git
    - git-lfs
    - gnupg
    - openssh-client
    - less
    - vim

download:
  - source: https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz
    unpack: hub-linux-amd64-2.14.2/bin/hub
    destination: /bin/hub

  - source: https://github.com/zaquestion/lab/releases/download/v0.20.0/lab_0.20.0_linux_amd64.tar.gz
    unpack: lab
    destination: /bin/lab

  - source: https://github.com/oclaussen/dormouse/releases/download/v0.1.3/dormouse_0.1.3_Linux_x86_64.tar.gz
    unpack: dormouse
    destination: /bin/dormouse

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
  - image: dodo/pass
    path: /bin/gopass
  - image: dodo/pass
    path: /home/dodo/.config/gopass
  - directory: dormouse.yaml
    path: /dormouse.yaml
