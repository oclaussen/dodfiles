FROM dodo/languages/buildbase AS build

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip install khal vdirsyncer requests-oauthlib

FROM dodo/base

RUN apt-get update \
 && apt-get install -y cron libsqlite3-0 \
 && chmod u+s /usr/sbin/cron

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && echo Europe/Berlin > /etc/timezone

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY root/ /

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
