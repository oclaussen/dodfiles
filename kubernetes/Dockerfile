FROM dodo/languages/buildbase AS build

RUN apt-get -y update \
 && apt-get -y install git

RUN curl -L -o /bin/kubectl \
    https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl \
 && chmod +x /bin/kubectl

RUN curl -L -o /tmp/k9s.tar.gz \
    https://github.com/derailed/k9s/releases/download/v0.20.5/k9s_Linux_x86_64.tar.gz \
 && tar -xzf /tmp/k9s.tar.gz -C /bin

RUN curl -L -o /tmp/krew.tar.gz \
    https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.tar.gz \
 && tar -xzf /tmp/krew.tar.gz -C /tmp \
 && curl -L -o /tmp/krew.yaml \
    https://github.com/kubernetes-sigs/krew/releases/download/v0.3.3/krew.yaml

RUN curl -L -o /tmp/popeye.tar.gz \
    https://github.com/derailed/popeye/releases/download/v0.7.1/popeye_Linux_x86_64.tar.gz \
 && tar -xzf /tmp/popeye.tar.gz -C /tmp

RUN curl -L -o /bin/kind \
    https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64 \
 && chmod +x /bin/kind

RUN curl -L -o /tmp/gopass.tgz \
    https://github.com/gopasspw/gopass/releases/download/v1.8.6/gopass-1.8.6-linux-amd64.tar.gz \
 && tar -xzf /tmp/gopass.tgz -C /tmp/ --strip-components=1

USER dodo
RUN /tmp/krew-linux_amd64 install --archive /tmp/krew.tar.gz --manifest /tmp/krew.yaml
ENV PATH /home/dodo/.krew/bin:${PATH}

RUN kubectl krew update \
 && kubectl krew install tree \
 && kubectl krew install ctx \
 && kubectl krew install ns

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        ncurses-bin \
        python3 \
        python3-pip \
        vim

RUN pip3 install --upgrade awscli

COPY --from=docker:19.03.1 /usr/local/bin/docker /bin/docker

COPY --from=build /bin/kubectl               /bin/kubectl
COPY --from=build /bin/k9s                   /bin/k9s
COPY --from=build /tmp/popeye                /bin/popeye
COPY --from=build /bin/kind                  /bin/kind
COPY --from=build /tmp/gopass                /bin/gopass

USER dodo
COPY --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg

COPY --from=build /home/dodo/.krew /home/dodo/.krew
ENV PATH /home/dodo/.krew/bin:${PATH}

COPY --chown=dodo:dodo home/ /home/dodo/
ENV KUBECONFIG /home/dodo/.kube/config:/home/dodo/.kubeconfig
