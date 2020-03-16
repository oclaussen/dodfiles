FROM dodo/languages/golang AS terraform-bundler
ARG terraform_version=0.11.14

RUN apt-get -y update \
 && apt-get install -y git zip

RUN go get -d -v github.com/hashicorp/terraform \
 && cd /root/go/src/github.com/hashicorp/terraform \
 && git checkout v${terraform_version} \
 && go install ./tools/terraform-bundle

COPY terraform-bundle-*.hcl .

RUN /root/go/bin/terraform-bundle package terraform-bundle-${terraform_version}.hcl \
 && mkdir -p terraform-bundle \
 && unzip -d terraform-bundle terraform_*.zip

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        bash \
        ca-certificates \
        curl \
        gettext \
        git \
        groff \
        jq \
        less \
        make \
        ncurses-base \
        ncurses-bin \
        openssh-client \
        python3 \
        python3-pip \
        sshpass \
        zip

RUN pip3 install --upgrade \
        ansible \
        argparse \
        awscli \
        boto3 \
        pywinrm

COPY --from=hashicorp/packer:1.3.4 /bin/packer           /bin/packer
COPY --from=terraform-bundler      /terraform-bundle/*   /bin/
RUn curl -L -o /bin/tfsec \
    https://github.com/liamg/tfsec/releases/download/v0.10.0/tfsec-linux-amd64 \
 && chmod +x /bin/tfsec

RUN curl -L -o session-manager-plugin.deb https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb \
 && dpkg -i session-manager-plugin.deb

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -L -o /bin/aws-iam-authenticator \
    https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x /bin/aws-iam-authenticator

RUN curl -L -o /bin/render \
    https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64 \
 && chmod +x /bin/render

USER dodo
