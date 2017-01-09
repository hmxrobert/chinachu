#!/bin/sh

/chinachu/chinachu service operator execute &
/chinachu/chinachu service wui execute &

tail -f /dev/null
