FROM dodo/languages/buildbase AS build

RUN curl -L -o /tmp/croc.tar.gz \
    https://github.com/schollz/croc/releases/download/v8.3.2/croc_8.3.2_Linux-64bit.tar.gz \
 && tar -xvzf /tmp/croc.tar.gz -C /tmp

FROM dodo/base

COPY --from=build /tmp/croc /bin/croc

USER dodo
