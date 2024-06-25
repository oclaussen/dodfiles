FROM dodo/base AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        autoconf \
        build-essential \
        bison \
 && apt-get clean

ENV RUBY_VERSION 3.3.3
ENV RUBY_DOWNLOAD_URL https://cache.ruby-lang.org/pub/ruby/3.3/ruby-3.3.3.tar.xz
ENV RUBY_DOWNLOAD_SHA256 83c0995388399c9555bad87e70af069755b5a9d84bbaa74aa22d1e37ff70fc1e

RUN wget -O ruby.tar.xz "$RUBY_DOWNLOAD_URL" \
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
      --prefix=/opt/ruby \
 && make -j "$(nproc)" \
 && make install

FROM dodo/base

COPY --from=build /opt/ruby /opt/ruby
COPY gemrc /opt/ruby/etc/gemrc

ENV GEM_HOME /opt/ruby/bundle
ENV BUNDLE_PATH "$GEM_HOME"
ENV BUNDLE_SILENCE_ROOT_WARNING 1
ENV BUNDLE_APP_CONFIG "$GEM_HOME"
ENV PATH $GEM_HOME/bin:$BUNDLE_PATH/gems/bin:/opt/ruby/bin:$PATH

RUN mkdir -p "$GEM_HOME" && chmod 777 "$GEM_HOME"
