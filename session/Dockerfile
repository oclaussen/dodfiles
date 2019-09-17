FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        curl \
        less \
        tmux \
        tzdata \
        zsh \
        libssl-dev \
        libyaml-dev

RUN cp /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
 && echo Europe/Berlin > /etc/timezone

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

RUN curl -L -o /bin/dodo \
    https://github.com/oclaussen/dodo/releases/download/1.4.0/dodo_linux_amd64 \
 && chmod +x /bin/dodo

COPY --from=dodo/languages/ruby /opt/ruby /opt/ruby
ENV GEM_HOME /opt/ruby/bundle
ENV PATH $GEM_HOME/bin:/opt/ruby/bin:$PATH

RUN gem install tmuxinator

COPY session.sh /session.sh
ENTRYPOINT ["/session.sh"]

USER dodo
COPY tmux.conf          /home/dodo/.tmux.conf
COPY tmuxinator         /home/dodo/.config/tmuxinator
COPY zshrc              /home/dodo/.zshrc
COPY dodo_redirect.yaml /home/dodo/.dodo.yaml
