#!/bin/sh
LABEL=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print $5}')
sketchybar --set $NAME label=$LABEL
