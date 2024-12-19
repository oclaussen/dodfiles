FROM dodo/base AS build

ARCH=amd64

RUN apt-get update \
 && apt-get install -y \
    ninja-build gettext cmake unzip curl git file build-essential

RUN git clone https://github.com/neovim/neovim /build \
 && cd /build \
 && git checkout stable \
 && make CMAKE_BUILD_TYPE=RelWithDebInfo \
 && cd build && cpack -G DEB

FROM dodo/base
RUN apt-get update && apt-get install -y curl git

COPY --from=dodo/languages/nodejs /opt/nodejs /opt/nodejs
ENV PATH /opt/nodejs/bin:$PATH
RUN yarn global add neovim

COPY --from=dodo/languages/golang /opt/go /opt/go
ENV PATH /opt/go/bin:$PATH

COPY --from=build /build/build/nvim-linux64.deb /tmp
RUN dpkg -i /tmp/nvim-linux64.deb && rm /tmp/nvim-linux64.deb

RUN curl -L -o /bin/chirp \
    https://github.com/oclaussen/chirp/releases/download/v2.0.1/chirp_linux_${ARCH} \
 && chmod +x /bin/chirp

ENV PATH /root/go/bin:$PATH
RUN go install golang.org/x/tools/gopls@latest

RUN curl -L -o /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

COPY home/ /root

RUN nvim --headless -n -i NONE \
    -c PlugUpgrade \
    -c PlugInstall \
    -c qall
