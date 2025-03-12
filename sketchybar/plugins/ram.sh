#!/bin/sh
LABEL=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print "RAM:"100-$5"%"}')
sketchybar --set $NAME label=$LABEL
