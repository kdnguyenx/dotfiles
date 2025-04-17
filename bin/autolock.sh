#!/usr/bin/bash
# check if the browser is currently playing audio
if pgrep -x 'firefox' > /dev/null; then
  if pactl list short sink-inputs | grep -q 'firefox'; then
    exit 0
  fi
fi
# check if any of the video players are running
players=('vlc' 'mpv' 'smplayer' 'mplayer')
for player in "${players[@]}"; do
  if pgrep -x "$player" > /dev/null; then
    exit 0
  fi
done
# if no video players are running, allow xautolock to lock the screen
exit 1
