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
 && apt-get upgrade -y -o Dpkg::Options::="--force-confdef" \
 && apt-get clean

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
COPY --from=chroot / /

ENV TERM xterm-256color
ENTRYPOINT ["/bin/bash"]
