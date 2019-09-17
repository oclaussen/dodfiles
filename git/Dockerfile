FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        git \
        git-lfs

USER dodo
COPY gitconfig /home/dodo/.gitconfig
