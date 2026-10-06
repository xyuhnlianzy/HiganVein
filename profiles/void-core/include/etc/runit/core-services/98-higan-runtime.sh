#!/bin/sh
# Initialize XDG runtime dir and socket permissions for sovereign user higan
mkdir -p /run/user/1001
chown higan:higan /run/user/1001
chmod 0700 /run/user/1001

# Ensure seatd permissions
mkdir -p /run
chmod 755 /run
