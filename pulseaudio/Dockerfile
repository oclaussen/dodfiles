FROM dodo/base

# TODO: move dbus, xserver etc into a separate container
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
	alsa-utils \
        dbus \
        dbus-user-session \
        dbus-x11 \
	libasound2 \
	libasound2-plugins \
	pulseaudio \
	pulseaudio-utils \
        xvfb \
 && apt-get clean

RUN usermod -aG audio,pulse,pulse-access dodo

COPY daemon.conf /etc/pulse/daemon.conf
COPY client.conf /etc/pulse/client.conf
COPY default.pa  /etc/pulse/default.pa
