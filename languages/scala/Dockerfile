FROM dodo/base
ARG JAVA_VERSION

RUN apt-get update \
 && apt-get install -y curl gnupg \
 && apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

COPY root/ /

RUN apt-get update \
 && apt-get install -y adoptopenjdk-11-hotspot sbt
