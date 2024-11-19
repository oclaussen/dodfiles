FROM dodo/base

ARG ARCH=amd64

RUN wget -O /tmp/go.tgz https://golang.org/dl/go1.22.4.linux-${ARCH}.tar.gz \
 && tar -C /opt -xzf /tmp/go.tgz \
 && rm /tmp/go.tgz

ENV PATH /opt/go/bin:$PATH
