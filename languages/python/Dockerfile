FROM dodo/languages/buildbase AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        libsqlite3-dev \
	tk-dev \
        uuid-dev \
 && apt-get clean

ENV PYTHON_VERSION 3.9.6
ENV GPG_KEY E3FF2839C048B25C084DEBE9B26995E310250568
ENV PYTHON_PIP_VERSION 19.2.3
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/309a56c5fd94bd1134053a541cb4657a4e47e09d/get-pip.py
ENV PYTHON_GET_PIP_SHA256 57e3643ff19f018f8a00dfaa6b7e4620e3c1a7a2171fd218425366ec006b3bfe

RUN wget -O python.tar.xz "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz" \
 && wget -O python.tar.xz.asc "https://www.python.org/ftp/python/${PYTHON_VERSION%%[a-z]*}/Python-$PYTHON_VERSION.tar.xz.asc" \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --batch --keyserver keys.openpgp.org --recv-keys "$GPG_KEY" \
 && gpg --batch --verify python.tar.xz.asc python.tar.xz \
 && { command -v gpgconf > /dev/null && gpgconf --kill all || :; } \
 && mkdir -p /src/python \
 && tar -xJf python.tar.xz -C /src/python --strip-components=1

WORKDIR /src/python
RUN ./configure \
      --build="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
      --enable-loadable-sqlite-extensions \
      --prefix=/opt/python \
 && make -j "$(nproc)" \
 && make install

RUN ln -s idle3 /opt/python/bin/idle \
 && ln -s pydoc3 /opt/python/bin/pydoc \
 && ln -s python3 /opt/python/bin/python \
 && ln -s python3-config /opt/python/bin/python-config

RUN wget -O get-pip.py "$PYTHON_GET_PIP_URL" \
 && echo "$PYTHON_GET_PIP_SHA256 *get-pip.py" | sha256sum --check --strict - \
 && /opt/python/bin/python get-pip.py --disable-pip-version-check --no-cache-dir "pip==$PYTHON_PIP_VERSION"

RUN find /opt/python -depth \
    \( \
    	\( -type d -a \( -name test -o -name tests \) \) \
    	-o \
    	\( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
    \) -exec rm -rf '{}' +

FROM dodo/base

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH
