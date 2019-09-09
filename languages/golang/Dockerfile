FROM dodo/base

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
 && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/go.tgz \
    https://golang.org/dl/go1.12.9.linux-amd64.tar.gz \
 && tar -C /opt -xzf /tmp/go.tgz \
 && rm /tmp/go.tgz

ENV PATH /opt/go/bin:$PATH
