#!/bin/sh
# HiganveinOS Stage 1 for s6 supervisor
/etc/rc.sysinit
exec /usr/bin/s6-svscan /etc/s6/scan
