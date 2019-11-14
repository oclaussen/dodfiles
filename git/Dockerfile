FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        bash-completion \
        git \
        git-lfs \
        less \
        vim \
        sqlite3

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install gitsome

USER dodo
COPY gitconfig /home/dodo/.gitconfig
COPY xonshrc   /home/dodo/.xonshrc
