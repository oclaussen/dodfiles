FROM dodo/languages/golang AS build

RUN apt-get -y update \
 && apt-get install -y curl git

RUN curl -L -o /bin/jira \
    https://github.com/go-jira/jira/releases/download/v1.0.26/jira-linux-amd64 \
 && chmod +x /bin/jira

RUN git clone https://github.com/mikepea/go-jira-ui /jira-ui
WORKDIR /jira-ui
RUN go build -o bin/jira-ui ./jira-ui

FROM dodo/base

RUN addgroup \
      --gid 1000 \
      dodo \
 && adduser \
      --uid 1000 \
      --gid 1000 \
      --gecos '' \
      --home /home/dodo \
      --shell /bin/bash \
      --disabled-password \
      dodo \
 && adduser dodo users

RUN apt-get -y update \
 && apt-get install -y gnupg

COPY --from=build /bin/jira /bin/jira
COPY --from=build /jira-ui/bin/jira-ui /bin/jira-ui

COPY --from=dodo/pass /bin/gopass /bin/gopass

USER dodo
COPY --chown=dodo:dodo --from=dodo/gpg /home/dodo/.gnupg/ /home/dodo/.gnupg
COPY --from=dodo/pass /home/dodo/.config/gopass/ /home/dodo/.config/gopass/
COPY --chown=dodo:dodo home/ /home/dodo/
