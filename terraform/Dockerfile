FROM dodo/languages/golang AS terraform-bundler

RUN apt-get update \
 && apt-get install -y git zip

RUN git clone --branch v0.13.5 https://github.com/hashicorp/terraform.git /terraform
RUN cd /terraform && go install ./tools/terraform-bundle

COPY terraform-bundle-0.13.5.hcl .

RUN /root/go/bin/terraform-bundle package terraform-bundle-0.13.5.hcl \
 && mkdir -p terraform-bundle \
 && unzip -d terraform-bundle terraform_*.zip

FROM dodo/languages/buildbase AS build

RUN curl -L -o /bin/terragrunt \
    https://github.com/gruntwork-io/terragrunt/releases/download/v0.25.5/terragrunt_linux_amd64 \
 && chmod +x /bin/terragrunt

RUN curl -L -o /bin/tfsec \
    https://github.com/liamg/tfsec/releases/download/v0.10.0/tfsec-linux-amd64 \
 && chmod +x /bin/tfsec

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -L -o /tmp/docker.tgz \
    https://download.docker.com/linux/static/stable/x86_64/docker-19.03.13.tgz \
 && tar -xvzf /tmp/docker.tgz --strip-components 1 -C /bin

FROM dodo/base

RUN apt-get update \
 && apt-get -y install git gnupg jq

COPY --from=dodo/aws /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

COPY --from=dodo/gcloud /opt/google-cloud-sdk /opt/google-cloud-sdk
ENV PATH /opt/google-cloud-sdk/bin:$PATH

COPY --from=terraform-bundler     /terraform-bundle/* /bin/
COPY --from=build /bin/terragrunt /bin/terragrunt
COPY --from=build /bin/kubectl    /bin/kubectl
COPY --from=build /bin/docker     /bin/docker
COPY --from=build /bin/tfsec      /bin/tfsec

COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --from=dodo/aws /home/dodo/.aws/ /home/dodo/.aws/
COPY --from=dodo/kube /home/dodo/.kubeconfig /home/dodo/.kubeconfig
COPY --chown=dodo:dodo home/ /home/dodo/
ENV KUBECONFIG /home/dodo/.kubeconfig
