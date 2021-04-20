# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

env:
  PATH: /opt/python/bin

packages:
  name:
    - curl
    - gnupg
    - groff
    - jq
    - less

download:
  - source: https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb
    destination: /tmp/session-manager-plugin.deb

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
  - directory: root
    path: /
  - directory: dormouse.yaml
    path: /dormouse.yaml

  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN pip3 install argparse awscli boto3
    path: /opt/python

run:
  - script: dpkg -i /tmp/session-manager-plugin.deb
