FROM dodo/base

RUN apt-get update \
 && apt-get -y install curl

RUN curl -L -o /bin/render \
    https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64 \
 && chmod +x /bin/render

USER dodo
