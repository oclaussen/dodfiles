FROM dodo/languages/buildbase AS build

RUN apt-get -y update \
 && apt-get -y install git

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -L -o /tmp/k9s.tar.gz \
    https://github.com/derailed/k9s/releases/download/v0.20.5/k9s_Linux_x86_64.tar.gz \
 && tar -xzf /tmp/k9s.tar.gz -C /bin

RUN curl -L -o /bin/aws-iam-authenticator \
    https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-07-26/bin/linux/amd64/aws-iam-authenticator \
 && chmod +x /bin/aws-iam-authenticator

RUN git clone https://github.com/ahmetb/kubectx /opt/kubectx

RUN curl -L -o /tmp/krew.tar.gz \
    https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.tar.gz \
 && tar -xzf /tmp/krew.tar.gz -C /tmp \
 && curl -L -o /tmp/krew.yaml \
    https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.yaml

RUN curl -L -o /tmp/popeye.tar.gz \
    https://github.com/derailed/popeye/releases/download/v0.7.1/popeye_Linux_x86_64.tar.gz \
 && tar -xzf /tmp/popeye.tar.gz -C /tmp

USER dodo
RUN /tmp/krew-linux_amd64 install --archive /tmp/krew.tar.gz --manifest /tmp/krew.yaml
ENV PATH /home/dodo/.krew/bin:${PATH}

RUN kubectl krew update \
 && kubectl krew install tree

FROM dodo/base

COPY --from=build /bin/kubectl               /bin/kubectl
COPY --from=build /bin/k9s                   /bin/k9s
COPY --from=build /bin/aws-iam-authenticator /bin/aws-iam-authenticator
COPY --from=build /tmp/popeye                /bin/popeye

COPY --from=build /opt/kubectx /opt/kubectx
RUN ln -s /opt/kubectx/kubectx /bin/kubectx \
 && ln -s /opt/kubectx/kubens  /bin/kubens

USER dodo

COPY --from=build /home/dodo/.krew /home/dodo/.krew
ENV PATH /home/dodo/.krew/bin:${PATH}
