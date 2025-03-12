#!/bin/sh
# the volume_change event supplies a $info variable in which the current volume
# percentage is passed to the script.
if [ "$SENDER" = "volume_change" ]; then
  percentage=$INFO
  result="+inf"
  if (( percentage == 0 )); then
    # log(0) is negative infinity
    result="-inf"
  else
    # convert the percentage to a decimal
    fraction=$(echo "scale=2; $percentage / 100" | bc -l)
    # calculate db using the formula: 20 * log10(fraction)
    result=$(echo "scale=3; 20 * (l($fraction) / l(10))" | bc -l)
    result="$result dB"
  fi
  sketchybar --set "$NAME" icon="|" label="$result"
fi
