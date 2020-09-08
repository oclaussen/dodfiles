FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install git git-lfs gnupg less vim

COPY --from=build /tmp/gopass /bin/gopass
COPY --from=build /bin/chirp  /bin/chirp

COPY root/ /

USER dodo
COPY --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --chown=dodo:dodo home/ /home/dodo/
