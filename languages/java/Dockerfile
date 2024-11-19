FROM dodo/base AS build

ARG ARCH=x64

ENV JAVA_SHA256 e59c6bf801cc023a1ea78eceb5e6756277f1564cd0a421ea984efe6cb96cfcf8
ENV JAVA_DOWNLOAD_URL https://github.com/adoptium/temurin22-binaries/releases/download/jdk-22.0.1%2B8/OpenJDK22U-jdk_${ARCH}_linux_hotspot_22.0.1_8.tar.gz

RUN wget --progress=dot:giga -O /tmp/openjdk.tar.gz ${JAVA_DOWNLOAD_URL} \
 && echo "${JAVA_SHA256} */tmp/openjdk.tar.gz" | sha256sum -c - \
 && mkdir -p /opt/java \
 && tar --extract \
        --file /tmp/openjdk.tar.gz \
        --directory /opt/java \
        --strip-components 1 \
        --no-same-owner \
 && rm -f /tmp/openjdk.tar.gz /opt/java/lib/src.zip \
 && find /opt/java/lib -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
 && ldconfig

ENV PATH /opt/java/bin:$PATH
