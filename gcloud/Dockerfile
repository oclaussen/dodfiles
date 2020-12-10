FROM dodo/base

RUN apt-get update \
 && apt-get -y install curl libsqlite3-0

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN curl -L -o /tmp/google-cloud-sdk.tar.gz \
    https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-320.0.0-linux-x86_64.tar.gz \
 && tar -xvzf /tmp/google-cloud-sdk.tar.gz -C /opt

ENV PATH /opt/google-cloud-sdk/bin:$PATH

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
