# syntax = oclaussen/dodfile-syntax
base_image: dodo/base

user:
  name: dodo
  dotfiles: home

packages:
  name:
    - gnupg

download:
  - source: https://github.com/go-jira/jira/releases/download/v1.0.26/jira-linux-amd64
    destination: /bin/jira

from:
  - image: dodo/gpg
    path: /home/dodo/.gnupg
  - image: dodo/pass
    path: /bin/gopass
  - image: dodo/pass
    path: /home/dodo/.config/gopass
  - dockerfile: |
      FROM dodo/languages/golang
      ENV PATH /opt/go/bin:$PATH
      RUN apt-get update && apt-get -y install git
      RUN git clone https://github.com/mikepea/go-jira-ui /jira-ui
      WORKDIR /jira-ui
      RUN go build -o bin/jira-ui ./jira-ui \
       && cp ./bin/* /bin/
    path: /bin/jira-ui
