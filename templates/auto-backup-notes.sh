#!/bin/bash
# vim:ft=bash
# - edit the cron jobs using `crontab -e`
# - add to the script `0 0 * * * /path/to/this >/tmp/stdout.log 2>/tmp/stderr.log` (0AM)
cd ~/notes
if [[ `git status --porcelain` ]]; then
  git add .
  git commit -m "automated commit $(date)"
  git push origin main
else
  echo "no changes to commit"
fi
