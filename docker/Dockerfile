FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install curl python3 python3-pip
RUN pip3 install --upgrade awscli

COPY --from=docker:19.03.1 /usr/local/bin/docker /bin/docker
COPY --from=quay.io/vektorlab/ctop:latest /ctop /bin/ctop

RUN curl -L -o /bin/docker-compose \
    https://github.com/docker/compose/releases/download/1.24.1/docker-compose-Linux-x86_64 \
 && chmod +x /bin/docker-compose

USER dodo
