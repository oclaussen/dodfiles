FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install openssh-client

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
