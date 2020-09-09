FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get -y install \
        libyaml-dev

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install \
        ansible \
        pywinrm

COPY --from=dodo/languages/ruby /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

RUN gem install \
        awspec \
        inspec \
        kitchen \
        kitchen-ec2 \
        kitchen-verifier-awspec \
        kitchen-inspec \
        psych

FROM dodo/base

RUN apt-get update \
 && apt-get -y install \
        gettext \
        git \
        gnupg \
        libyaml-0-2 \
        openssh-client \
        sshpass \
        zip

COPY --from=hashicorp/packer:1.4.1 /bin/packer /bin/packer

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY --from=build /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
