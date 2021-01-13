FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        bison \
        libevent-dev \
        ncurses-dev \
        pkg-config

RUN git clone https://github.com/tmux/tmux.git /tmux \
 && cd /tmux \
 && sh autogen.sh \
 && ./configure \
 && make

COPY --from=dodo/languages/ruby /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

RUN gem install tmuxinator

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

FROM dodo/languages/buildbase AS dodo

COPY --from=dodo/languages/golang /opt/go /opt/go
ENV PATH /opt/go/bin:$PATH

RUN git clone -b master https://github.com/dodo-cli/dodo /dodo
COPY generate.yaml /dodo/generate.yaml
WORKDIR /dodo
RUN go generate . && go build .

FROM dodo/base

RUN addgroup \
      --gid 1000 \
      dodo \
 && adduser \
      --uid 1000 \
      --gid 1000 \
      --gecos '' \
      --home /home/dodo \
      --shell /bin/bash \
      --disabled-password \
      dodo \
 && adduser dodo users

RUN apt-get update \
 && apt-get  install -y --no-install-recommends \
        libevent-dev \
        libyaml-dev \
        ncurses-dev

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && echo Europe/Berlin > /etc/timezone

COPY --from=build /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

COPY --from=build /tmux/tmux /bin/tmux
COPY --from=build /bin/chirp /bin/chirp
COPY --from=dodo /dodo/dodo /bin/dodo

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
