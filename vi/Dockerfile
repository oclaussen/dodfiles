FROM bitnami/minideb:buster

RUN apt-get -y update \
 && apt-get -y install \
        ctags \
        curl \
        git \
        neovim

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

RUN git clone https://github.com/VundleVim/Vundle.vim /root/.config/nvim/bundle/vundle

COPY vimrc /root/.config/nvim/init.vim
RUN nvim --headless -n -i NONE -c VundleUpdate -c PluginInstall -c qall
