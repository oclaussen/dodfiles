FROM golang:1.12.9-stretch AS terraform-bundler

RUN apt-get -y update \
 && apt-get install -y git zip

RUN go get -d -v github.com/hashicorp/terraform \
 && cd $GOPATH/src/github.com/hashicorp/terraform \
 && git checkout v0.11.14 \
 && go install ./tools/terraform-bundle

COPY terraform-bundle.hcl .

RUN terraform-bundle package terraform-bundle.hcl \
 && mkdir -p terraform-bundle \
 && unzip -d terraform-bundle terraform_*.zip

FROM bitnami/minideb:stretch

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
        openssh-client \
        python3 \
        python3-pip \
        sshpass \
        zip

RUN pip3 install --upgrade \
        ansible \
        argparse \
        awscli \
        boto3

COPY --from=docker:19.03.1         /usr/local/bin/docker  /bin/docker
COPY --from=hashicorp/packer:1.3.4 /bin/packer            /bin/packer
COPY --from=terraform-bundler      /go/terraform-bundle/* /bin/

RUN curl -o session-manager-plugin.deb https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb \
 && dpkg -i session-manager-plugin.deb

RUN curl -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -o /bin/aws-iam-authenticator \
    https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x /bin/aws-iam-authenticator

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx \
 && ln -s /opt/kubectx/kubectx /bin/kubectx \
 && ln -s /opt/kubectx/kubens /bin/kubens

RUN curl -o /bin/render \
    https://github.com/VirtusLab/render/releases/download/v0.1.3/render-linux-amd64 \
 && chmod +x /bin/render
