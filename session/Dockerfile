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
    broot \
    exa \
    fd-find \
    procs \
    ripgrep \
    sd \
    starship \
    tokei \
    xsv

RUN gem install tmuxinator

RUN git clone https://github.com/denisidoro/navi /opt/navi \
 && /opt/navi/scripts/install /bin


FROM dodo/base

RUN apt-get update \
 && apt-get  install -y --no-install-recommends \
        curl \
        less \
        man \
        procps \
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
    https://github.com/oclaussen/dodo/releases/download/1.6.0/dodo_linux_amd64 \
 && chmod +x /bin/dodo

RUN curl -L -o /tmp/fzf.tgz \
    https://github.com/junegunn/fzf-bin/releases/download/0.19.0/fzf-0.19.0-linux_amd64.tgz \
 && tar xvzf /tmp/fzf.tgz -C /bin

COPY --from=build /opt/rust /opt/rust
ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
ENV PATH ${CARGO_HOME}/bin:$PATH

COPY --from=build /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

COPY --from=build /opt/navi /opt/navi
COPY --from=build /bin/navi /bin/navi

USER dodo
RUN mkdir -p /home/dodo/.config
COPY tmux.conf          /home/dodo/.tmux.conf
COPY tmuxinator         /home/dodo/.config/tmuxinator
COPY zshrc              /home/dodo/.zshrc
COPY dodo_redirect.yaml /home/dodo/.dodo.yaml
