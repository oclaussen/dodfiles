FROM dodo/languages/buildbase AS build

ARG JDK_URL

RUN wget -O openjdk.tgz.asc "${JDK_URL}.sign" \
 && wget -O openjdk.tgz "${JDK_URL}" --progress=dot:giga \
 && export GNUPGHOME="$(mktemp -d)" \
 && gpg --batch --keyserver ha.pool.sks-keyservers.net --keyserver-options no-self-sigs-only --recv-keys CA5F11C6CE22644D42C6AC4492EF8D39DC13168F \
 && gpg --batch --keyserver ha.pool.sks-keyservers.net --recv-keys EAC843EBD3EFDB98CC772FADA5CD6035332FA671 \
 && gpg --batch --verify openjdk.tgz.asc openjdk.tgz \
 && gpgconf --kill all \
 && mkdir -p /opt/java \
 && tar -xzf openjdk.tgz -C /opt/java --strip-components=1 --no-same-owner

FROM dodo/base

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        fontconfig \
        libfreetype6 \
        p11-kit

COPY --from=build /opt/java /opt/java
ENV JAVA_HOME /opt/java
ENV PATH /opt/java/bin:$PATH

COPY root/ /
RUN /etc/ca-certificates/update.d/docker-openjdk

RUN find /opt/java/lib -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
 && ldconfig
