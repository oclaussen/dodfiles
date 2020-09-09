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

RUN curl -L -o /bin/tfsec \
    https://github.com/liamg/tfsec/releases/download/v0.10.0/tfsec-linux-amd64 \
 && chmod +x /bin/tfsec

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

FROM dodo/base

RUN apt-get update \
 && apt-get -y install git gnupg jq

COPY --from=dodo/aws /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY --from=terraform-bundler  /terraform-bundle/* /bin/
COPY --from=build /bin/kubectl /bin/kubectl
COPY --from=build /bin/tfsec   /bin/tfsec

COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --from=dodo/aws /home/dodo/.aws/ /home/dodo/.aws/
COPY --chown=dodo:dodo home/ /home/dodo/
