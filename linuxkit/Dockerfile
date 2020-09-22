FROM dodo/languages/buildbase AS build

COPY --from=dodo/languages/golang /opt/go /opt/go
ENV PATH /opt/go/bin:$PATH

RUN go get -u github.com/linuxkit/linuxkit/src/cmd/linuxkit

FROM dodo/base

RUN apt-get update && apt-get install -y git

COPY --from=docker:19.03.1 /usr/local/bin/docker /bin/docker

COPY --from=build /root/go/bin/linuxkit /bin/linuxkit

USER dodo
