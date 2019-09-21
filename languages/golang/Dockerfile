FROM dodo/base

RUN wget -O /tmp/go.tgz https://golang.org/dl/go1.12.9.linux-amd64.tar.gz \
 && tar -C /opt -xzf /tmp/go.tgz \
 && rm /tmp/go.tgz

ENV PATH /opt/go/bin:$PATH
