#!/bin/sh


xhost +
docker run --privileged -e "DISPLAY=unix:0.0" -v="/tmp/.X11-unix:/tmp/.X11-unix:rw" -i -t aalmodovar/archlinux-ati-base /bin/bash
