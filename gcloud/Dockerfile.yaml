# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

env:
  PATH: /opt/google-cloud-sdk/bin:/opt/python/bin

packages:
  name:
    - libsqlite3-0

download:
  - source: https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-320.0.0-linux-x86_64.tar.gz
    destination: /tmp/google-cloud-sdk.tar.gz

from:
  - image: dodo/languages/python
    path: /opt/python

run:
  - script: tar -xvzf /tmp/google-cloud-sdk.tar.gz -C /opt
