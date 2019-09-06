FROM bitnami/minideb:buster

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        ca-certificates \
        ctags \
        curl \
        git \
        neovim \
 && rm -rf /var/lib/apt/lists/*

RUN curl -L -o /tmp/go.tgz \
    https://golang.org/dl/go1.12.9.linux-amd64.tar.gz \
 && tar -C /usr/local -xzf /tmp/go.tgz \
 && rm /tmp/go.tgz
ENV PATH /usr/local/go/bin:$PATH

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

RUN git clone https://github.com/VundleVim/Vundle.vim /root/.config/nvim/bundle/vundle

COPY vimrc /root/.config/nvim/init.vim
RUN nvim --headless -n -i NONE \
    -c VundleUpdate \
    -c PluginInstall \
    -c GoInstallBinaries \
    -c qall
