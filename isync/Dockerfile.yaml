# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

packages:
  name:
    - gnupg
    - isync

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
  - image: dodo/pass
    path: /bin/gopass
  - image: dodo/pass
    path: /home/dodo/.config/gopass
