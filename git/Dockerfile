FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/hub.tar.gz \
    https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz \
 && tar -xzf /tmp/hub.tar.gz -C /tmp

RUN curl -L -o /tmp/lab.tar.gz \
    https://github.com/zaquestion/lab/releases/download/v0.17.2/lab_0.17.2_linux_amd64.tar.gz \
 && tar -xzf /tmp/lab.tar.gz -C /tmp

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
 && apt-get -y install \
        git \
        git-lfs \
        less \
        vim

COPY --from=build /tmp/hub-linux-amd64-2.14.2/bin/hub /bin/hub
COPY --from=build /tmp/lab /bin/lab

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --chown=dodo:dodo home/ /home/dodo/
