#!/bin/sh
# the volume_change event supplies a $info variable in which the current volume
# percentage is passed to the script.
if [ "$SENDER" = "volume_change" ]; then
  volume_percentage=$INFO
  value="+inf"
  if (( volume_percentage == 0 )); then
    value="-inf"  # log(0) is negative infinity
  else
    # convert the percentage to a decimal
    volume_decimal=$(echo "scale=3; $volume_percentage / 100" | bc -l)
    # calculate db using the formula: 20 * log10(volume_decimal)
    db=$(echo "scale=3; 20 * l($volume_decimal) / l(10)" | bc -l)
    value="$db dB"
  fi
  sketchybar --set "$NAME" icon="|" label="$value"
fi
