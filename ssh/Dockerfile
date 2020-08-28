FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install gnupg openssh-client

COPY --from=build /tmp/gopass  /bin/gopass

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
