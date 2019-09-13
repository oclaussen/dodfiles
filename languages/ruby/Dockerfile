FROM dodo/base AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        autoconf \
        bison \
        build-essential \
        ca-certificates \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        libncurses5-dev \
        libffi-dev \
        libgdbm-dev \
        wget \
        zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

ENV RUBY_MAJOR 2.6
ENV RUBY_VERSION 2.6.4
ENV RUBY_DOWNLOAD_SHA256 df593cd4c017de19adf5d0154b8391bb057cef1b72ecdd4a8ee30d3235c65f09

RUN wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-$RUBY_VERSION.tar.xz" \
 && echo "$RUBY_DOWNLOAD_SHA256 *ruby.tar.xz" | sha256sum --check --strict \
 && mkdir -p /src/ruby \
 && tar -xJf ruby.tar.xz -C /src/ruby --strip-components=1

WORKDIR /src/ruby
COPY disable_path_check.patch .
RUN patch < disable_path_check.patch \
 && autoconf \
 && ./configure \
      --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
      --disable-install-doc \
      --enable-shared \
      --prefix=/opt/ruby \
 && make -j "$(nproc)" \
 && make install

FROM dodo/base

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        libc6 \
 && rm -rf /var/lib/apt/lists/*

COPY --from=build /opt/ruby /opt/ruby
COPY gemrc /opt/ruby/etc/gemrc

ENV GEM_HOME /opt/ruby/bundle
ENV BUNDLE_PATH "$GEM_HOME"
ENV BUNDLE_SILENCE_ROOT_WARNING 1
ENV BUNDLE_APP_CONFIG "$GEM_HOME"
ENV PATH $GEM_HOME/bin:$BUNDLE_PATH/gems/bin:/opt/ruby/bin:$PATH

RUN mkdir -p "$GEM_HOME" && chmod 777 "$GEM_HOME"
