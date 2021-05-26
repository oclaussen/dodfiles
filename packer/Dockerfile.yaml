# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo

env:
  GEM_HOME: /opt/ruby/bundle
  PATH: /opt/python/bin:/opt/ruby/bundle/bin:/opt/ruby/bin

packages:
  name:
    - gettext
    - git
    - gnupg
    - libyaml-0-2
    - openssh-client
    - sshpass
    - zip

download:
  - source: https://releases.hashicorp.com/packer/1.7.2/packer_1.7.2_linux_amd64.zip
    unpack: packer
    destination: /bin/packer

from:
  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN apt-get update && apt-get install -y libyaml-dev
      RUN pip3 install ansible pywinrm
    path: /opt/python

  - dockerfile: |
      FROM dodo/languages/ruby
      ENV GEM_HOME /opt/ruby/bundle
      ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH
      RUN apt-get update && apt-get install -y make gcc libffi-dev libyaml-dev
      RUN gem install psych \
              kitchen kitchen-ec2 \
              awspec kitchen-verifier-awspec \
              inspec kitchen-inspec
    path: /opt/ruby

  - image: dodo/gpg
    path: /home/dodo/.gnupg
  - image: dodo/pass
    path: /bin/gopass
  - image: dodo/pass
    path: /home/dodo/.config/gopass
  - image: dodo/aws
    path: /home/dodo/.aws
