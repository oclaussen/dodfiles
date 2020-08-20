#!/bin/sh
set -eux

/opt/python/bin/vdirsyncer sync
/opt/python/bin/khal at now 
