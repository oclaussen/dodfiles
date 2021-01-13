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

RUN apt-get update \
 && apt-get -y install curl

RUN curl -L -o /bin/render \
    https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64 \
 && chmod +x /bin/render

USER dodo
