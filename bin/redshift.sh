#!/usr/bin/bash
# vim: ft=bash
if pgrep -x 'redshift' > /dev/null; then
  pkill redshift &
  notify-send 'redshift disabled'
else
  redshift -l 10.8:106.6 &
  notify-send 'redshift enabled'
fi
