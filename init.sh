#!/bin/sh

if [ -e /var/run/chinachu-operator.pid ]; then
  rm /var/run/chinachu-operator.pid
fi

if [ -e /var/run/chinachu-wui.pid ]; then
  rm /var/run/chinachu-wui.pid
fi

/etc/init.d/chinachu-operator start
/etc/init.d/chinachu-wui start

tail -f /dev/null
