FROM dodo/base

RUN apt-get -y update \
 && apt-get -y install \
        git \
        git-lfs \
        sqlite3

COPY --from=dodo/languages/python /opt/python /opt/python
ENV PATH /opt/python/bin:$PATH

RUN pip3 install gitsome

USER dodo
COPY gitconfig /home/dodo/.gitconfig
COPY xonshrc   /home/dodo/.xonshrc
