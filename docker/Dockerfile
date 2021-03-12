# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo

env:
  DOCKER_TLS_CERTDIR: /certs

packages:
  name:
   - btrfs-progs
   - e2fsprogs
   - iptables
   - iproute2
   - openssl
   - xfsprogs

download:
  - source: https://download.docker.com/linux/static/stable/x86_64/docker-19.03.13.tgz
    unpack: docker/docker
    destination: /bin/docker
    # TODO: same for ctr, runc, containerd-shim, docker-init, docker-proxy, dockerd, containerd

  - source: https://raw.githubusercontent.com/docker/docker/ed89041433a031cafc0a0f19cfe573c31688d377/hack/dind
    destination: /bin/dind

  - source: https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64
    destination: /bin/docker-compose

  - source: https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-19.03.13.tgz
    unpack: docker-rootless-extras/rootlesskit
    destination: /bin/rootlesskit
    # TODO: some for vpnkit, rootlesskit-docker-proxy, dockerd-rootless.sh

  - source: https://github.com/bcicen/ctop/releases/download/v0.7.5/ctop-0.7.5-linux-amd64
    destination: /bin/ctop

  - source: https://github.com/docker/buildx/releases/download/v0.5.1/buildx-v0.5.1.linux-amd64
    destination: /usr/lib/docker/cli-plugins/docker-buildx

  - source: https://github.com/oclaussen/dormouse/releases/download/v0.1.1/dormouse_0.1.1_Linux_x86_64.tar.gz
    unpack: dormouse
    destination: /bin/dormouse

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
  - image: dodo/pass
    path: /bin/gopass
  - image: dodo/pass
    path: /home/dodo/.config/gopass
  - image: dodo/aws
    path: /home/dodo/.aws
  - directory: dormouse.yaml
    path: /dormouse.yaml

  - dockerfile: |
      FROM dodo/languages/python
      ENV PATH /opt/python/bin:$PATH
      RUN pip3 install awscli
    path: /opt/python

run:
  - script: |
      mkdir /certs /certs/client
      chmod 1777 /certs /certs/client
      mkdir /run/user
      chmod 1777 /run/user
      mkdir -p /home/dodo/.local/share/docker
      chown -R dodo:dodo /home/dodo/.local/share/docker
