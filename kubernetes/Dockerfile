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

USER dodo
RUN /tmp/krew-linux_amd64 install --archive /tmp/krew.tar.gz --manifest /tmp/krew.yaml
ENV PATH /home/dodo/.krew/bin:${PATH}

RUN kubectl krew update \
 && kubectl krew install tree \
 && kubectl krew install ctx \
 && kubectl krew install ns \
 && kubectl krew install neat

FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install gnupg ncurses-bin vim

COPY --from=docker:19.03.1 /usr/local/bin/docker /bin/docker

COPY --from=build /bin/kubectl               /bin/kubectl
COPY --from=build /bin/k9s                   /bin/k9s
COPY --from=build /tmp/popeye                /bin/popeye
COPY --from=build /bin/kind                  /bin/kind

COPY --from=dodo/pass /bin/gopass /bin/gopass

COPY --from=dodo/aws /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --from=dodo/aws /home/dodo/.aws/ /home/dodo/.aws/

COPY --from=build /home/dodo/.krew /home/dodo/.krew
ENV PATH /home/dodo/.krew/bin:${PATH}

COPY --chown=dodo:dodo home/ /home/dodo/
ENV KUBECONFIG /home/dodo/.kube/config:/home/dodo/.kubeconfig
