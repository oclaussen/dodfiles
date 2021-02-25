# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo

env:
  EDITOR: vim

packages:
  name:
    - gnupg
    - vim

download:
  - source: https://github.com/mozilla/sops/releases/download/v3.6.1/sops-v3.6.1.linux
    destination: /bin/sops

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
