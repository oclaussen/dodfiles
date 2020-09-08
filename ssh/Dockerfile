FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install openssh-client

USER dodo
COPY --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --chown=dodo:dodo home/ /home/dodo/
