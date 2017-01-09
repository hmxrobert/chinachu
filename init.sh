#!/bin/sh

sh /etc/init.d/chinachu-operator &
sh /etc/init.d/chinachu-wui &

tail -f /dev/null
