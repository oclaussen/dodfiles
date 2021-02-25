FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1

RUN curl -L -o /tmp/chirp.tgz \
    https://github.com/oclaussen/chirp/releases/download/v2.0.0/chirp_2.0.0_Linux_x86_64.tar.gz \
 && tar xvzf /tmp/chirp.tgz -C /bin

FROM dodo/base

RUN addgroup \
      --gid 1000 \
      dodo \
 && adduser \
      --uid 1000 \
      --gid 1000 \
      --gecos '' \
      --home /home/dodo \
      --shell /bin/bash \
      --disabled-password \
      dodo \
 && adduser dodo users

RUN apt-get -y update \
 && apt-get -y install git git-lfs gnupg less vim

COPY --from=build /tmp/gopass /bin/gopass
COPY --from=build /bin/chirp  /bin/chirp

COPY root/ /

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --chown=dodo:dodo home/ /home/dodo/
