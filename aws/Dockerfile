FROM dodo/base

RUN apt-get update \
 && apt-get -y install \
        curl \
        gnupg \
        groff \
        jq \
        less

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install argparse awscli boto3

RUN curl -L -o session-manager-plugin.deb https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb \
 && dpkg -i session-manager-plugin.deb

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1 \
 && mv /tmp/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
