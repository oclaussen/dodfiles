FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get install -y \
        clang \
        pkg-config

COPY --from=dodo/languages/rust /opt/rust /opt/rust
ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
ENV PATH ${CARGO_HOME}/bin:$PATH

RUN cargo install \
    bat \
    broot \
    exa \
    fd-find \
    procs \
    ripgrep \
    sd \
    tokei \
    xsv

RUN cargo install \
    --git https://github.com/starship/starship.git \
    --branch master

RUN git clone https://github.com/denisidoro/navi /opt/navi \
 && BIN_DIR=/bin /opt/navi/scripts/install

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

RUN curl -L -o /tmp/fzf.tgz \
    https://github.com/junegunn/fzf-bin/releases/download/0.19.0/fzf-0.19.0-linux_amd64.tgz \
 && tar xvzf /tmp/fzf.tgz -C /bin

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
 && apt-get  install -y \
        less \
        man \
        procps \
        zsh

COPY --from=build /opt/rust /opt/rust
ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
ENV PATH ${CARGO_HOME}/bin:$PATH

COPY --from=build /opt/navi /opt/navi
COPY --from=build /bin/navi /bin/navi
COPY --from=build /bin/chirp /bin/chirp
COPY --from=build /bin/fzf /bin/fzf
COPY --from=dodo /dodo/dodo /bin/dodo

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
