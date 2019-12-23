FROM dodo/base AS build
ENV LANG C.UTF-8

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        autoconf \
        build-essential \
        curl \
        git \
        gnupg2 \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm-dev \
        zlib1g-dev \
 && apt-get clean
