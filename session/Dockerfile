FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        clang \
 && apt-get clean

COPY --from=dodo/languages/rust /opt/rust /opt/rust
ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
ENV PATH ${CARGO_HOME}/bin:$PATH

COPY --from=dodo/languages/ruby /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

RUN cargo install \
    bat \
    exa \
    fd \
    procs \
    ripgrep \
    sd \
    starship \
    tokei \
    xsv

RUN gem install tmuxinator


FROM dodo/base

RUN apt-get update \
 && apt-get  install -y --no-install-recommends \
        curl \
        less \
        tmux \
        zsh \
        libyaml-dev \
 && apt-get clean

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && echo Europe/Berlin > /etc/timezone

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

RUN curl -L -o /bin/dodo \
    https://github.com/oclaussen/dodo/releases/download/1.4.1/dodo_linux_amd64 \
 && chmod +x /bin/dodo

COPY --from=build /opt/rust /opt/rust
COPY --from=build /opt/ruby /opt/ruby

COPY session.sh /session.sh
ENTRYPOINT ["/session.sh"]

USER dodo
RUN mkdir -p /home/dodo/.config
COPY tmux.conf          /home/dodo/.tmux.conf
COPY tmuxinator         /home/dodo/.config/tmuxinator
COPY zshrc              /home/dodo/.zshrc
COPY dodo_redirect.yaml /home/dodo/.dodo.yaml
