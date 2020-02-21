FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/nvim.appimage \
    https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage \
 && chmod +x /tmp/nvim.appimage \
 && /tmp/nvim.appimage --appimage-extract \
 && find squashfs-root -type d -exec chmod 755 {} \; \
 && find squashfs-root -type f -exec chmod 644 {} \; \
 && find squashfs-root/usr/bin -type f -exec chmod 755 {} \;

RUN curl -L -o /tmp/terraform-lsp.tar.gz \
    https://github.com/juliosueiras/terraform-lsp/releases/download/v0.0.10/terraform-lsp_0.0.10_linux_amd64.tar.gz \
 && tar -xvzf /tmp/terraform-lsp.tar.gz -C /tmp

FROM dodo/base

RUN apt-get update && apt-get install -y curl git

COPY --from=dodo/languages/nodejs /opt/nodejs /opt/nodejs
ENV PATH /opt/nodejs/bin:$PATH
RUN yarn global add neovim

COPY --from=dodo/languages/golang /opt/go /opt/go
ENV PATH /opt/go/bin:$PATH

COPY --from=build /squashfs-root /opt/nvim
ENV PATH /opt/nvim/usr/bin:$PATH

COPY --from=build /tmp/terraform-lsp /bin/terraform-lsp

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/1.0/chirp_linux_amd64 \
 && chmod +x /bin/chirp

USER dodo

ENV PATH /home/dodo/go/bin:$PATH
ENV GO111MODULE on
RUN go get golang.org/x/tools/gopls@latest

RUN curl -L -o /home/dodo/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN mkdir -p /home/dodo/.config/nvim
COPY vimrc /home/dodo/.config/nvim/init.vim
COPY coc-settings.json /home/dodo/.config/nvim/coc-settings.json

RUN nvim --headless -n -i NONE \
    -c PlugUpgrade \
    -c PlugInstall \
    -c qall
