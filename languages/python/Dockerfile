FROM dodo/base AS build

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        build-essential \
        gnupg2 \
        libbz2-dev \
        libssl-dev \
        libyaml-dev \
        libreadline6-dev \
        libncurses5-dev \
        libffi-dev \
        libsqlite3-dev \
	tk-dev \
        uuid-dev \
 && apt-get clean

ENV PYTHON_VERSION 3.12.3
ENV GPG_KEY 7169605F62C751356D054A26A821E680E5FA6305
ENV PYTHON_PIP_VERSION 24.0
ENV PYTHON_GET_PIP_URL https://github.com/pypa/get-pip/raw/dbf0c85f76fb6e1ab42aa672ffca6f0a675d9ee4/public/get-pip.py
ENV PYTHON_GET_PIP_SHA256 dfe9fd5c28dc98b5ac17979a953ea550cec37ae1b47a5116007395bfacff2ab9

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
