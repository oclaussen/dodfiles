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

COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --chown=dodo:dodo home/ /home/dodo/
