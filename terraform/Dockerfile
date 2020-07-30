FROM dodo/languages/golang AS terraform-bundler
ARG terraform_version=0.11.14

RUN apt-get update \
 && apt-get install -y git zip

RUN go get -d -v github.com/hashicorp/terraform \
 && cd /root/go/src/github.com/hashicorp/terraform \
 && git checkout v${terraform_version} \
 && go install ./tools/terraform-bundle

COPY terraform-bundle-*.hcl .

RUN /root/go/bin/terraform-bundle package terraform-bundle-${terraform_version}.hcl \
 && mkdir -p terraform-bundle \
 && unzip -d terraform-bundle terraform_*.zip

FROM dodo/languages/buildbase AS build

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install awscli

RUN curl -L -o /bin/tfsec \
    https://github.com/liamg/tfsec/releases/download/v0.10.0/tfsec-linux-amd64 \
 && chmod +x /bin/tfsec

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1

FROM dodo/base

RUN apt-get update \
 && apt-get -y install git gnupg jq

COPY --from=build /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY --from=terraform-bundler  /terraform-bundle/* /bin/
COPY --from=build /bin/kubectl /bin/kubectl
COPY --from=build /bin/tfsec   /bin/tfsec
COPY --from=build /tmp/gopass  /bin/gopass

USER dodo
COPY --chown=dodo:dodo home/ /home/dodo/
