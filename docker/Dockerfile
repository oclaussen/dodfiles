FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/docker.tgz \
    https://download.docker.com/linux/static/stable/x86_64/docker-19.03.13.tgz \
 && tar -xvzf /tmp/docker.tgz --strip-components 1 -C /bin

RUN curl -L -o /bin/dind \
    https://raw.githubusercontent.com/docker/docker/ed89041433a031cafc0a0f19cfe573c31688d377/hack/dind \
 && chmod +x /bin/dind

RUN curl -L -o /tmp/rootless.tgz https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-19.03.13.tgz \
 && tar -xvzf /tmp/rootless.tgz  --strip-components 1 -C /bin

RUN curl -L -o /bin/docker-compose \
    https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64 \
 && chmod +x /bin/docker-compose

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
            python3 \
            python3-pip \
            btrfs-progs \
            e2fsprogs \
            iptables \
            iproute2 \
            openssl \
            xfsprogs

RUN pip3 install --upgrade awscli

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client

RUN mkdir /run/user && chmod 1777 /run/user

RUN mkdir -p /home/dodo/.local/share/docker && chown -R dodo:dodo /home/dodo/.local/share/docker

COPY --from=build /bin/docker /bin/docker
COPY --from=build /bin/dind /bin/dind
COPY --from=build /bin/docker-compose /bin/docker-compose
COPY --from=quay.io/vektorlab/ctop:latest /ctop /bin/ctop
COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --from=dodo/aws /home/dodo/.aws/ /home/dodo/.aws/
