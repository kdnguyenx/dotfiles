#!/usr/bin/bash
players=('vlc' 'mpv' 'smplayer' 'mplayer')

# check if any of the video players are running
for player in "${players[@]}"; do
  if pgrep -x "$player" > /dev/null; then
    exit 0
  fi
done
# if no video players are running, allow xautolock to lock the screen
exit 1
