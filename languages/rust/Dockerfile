FROM dodo/base AS build

ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
RUN wget -O rustup-init "https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init" \
 && chmod +x rustup-init

RUN ./rustup-init -y --no-modify-path

FROM dodo/base

COPY --from=build /opt/rust /opt/rust
ENV RUSTUP_HOME=/opt/rust/rustup CARGO_HOME=/opt/rust/cargo
ENV PATH ${CARGO_HOME}/bin:$PATH
