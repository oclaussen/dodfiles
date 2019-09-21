# Bootstrap in Debian using multistrap
FROM debian:buster AS bootstrap
ENV DEBIAN_FRONTEND=noninteractive

# Build dependencies
RUN apt-get update \
 && apt-get install -y \
    multistrap \
    debian-archive-keyring

# Multistrap
COPY multistrap.conf /multistrap.conf
RUN multistrap -d /rootfs -f /multistrap.conf


# Additional customization in separate image acting as chroot
FROM scratch AS chroot
ENV DEBIAN_FRONTEND=noninteractive
COPY --from=bootstrap /rootfs/ /

# General configuration
COPY root/ /
RUN dpkg --configure -a \
 && dpkg-divert --local --add /sbin/initctl

# Update everything
RUN apt-get update \
 && apt-get upgrade --with-new-pkgs -y -o Dpkg::Options::="--force-confdef" \
 && apt-get clean

# Users and groups
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

# Cleanup
RUN rm -r /usr/share/info/* \
 && rm -r /usr/share/locale/* \
 && rm -r /usr/share/man/* \
 && rm -r /var/cache/apt/* \
 && rm -r /var/lib/apt/lists/* \
 && rm -r /var/log/* \
 && find /usr/share/doc -delete -mindepth 1 -not -name copyright -not -type d \
 && find /usr/share/doc -delete -mindepth 1 -type d -empty


# Final image
FROM scratch
MAINTAINER Ole Claussen <claussen.ole@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive
COPY --from=chroot / /
