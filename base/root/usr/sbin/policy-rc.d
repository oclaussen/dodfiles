#!/bin/sh

# From https://github.com/moby/moby/blob/master/contrib/mkimage/debootstrap

# For most Docker users, "apt-get install" only happens during "docker build",
# where starting services doesn't work and often fails in humorous ways. This
# prevents those failures by stopping the services from attempting to start.

exit 101
