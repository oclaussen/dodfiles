FROM alpine:3.10

RUN apk add -U neovim git ctags
RUN git clone https://github.com/VundleVim/Vundle.vim /root/.config/nvim/bundle/vundle

COPY vimrc /root/.config/nvim/init.vim
RUN nvim --headless -n -i NONE -c VundleUpdate -c PluginInstall -c qall
