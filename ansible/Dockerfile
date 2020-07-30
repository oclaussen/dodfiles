FROM dodo/languages/buildbase AS build

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install ansible pywinrm

FROM dodo/base

RUN apt-get update \
 && apt-get -y install \
        gettext \
        openssh-client \
        sshpass \
        zip

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH
