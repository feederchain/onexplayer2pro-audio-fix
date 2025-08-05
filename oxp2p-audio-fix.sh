#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script should be run by root!" >&2
    exit 1
fi

if ! command -v hda-verb >/dev/null; then
    echo "hda-verb is required but not found in PATH. Please install alsa-tools first." >&2
    exit 2
fi

# Default: not auto-confirmed
AUTO_CONFIRM=0

# Parse command-line options
while getopts "y" opt; do
  case $opt in
    y)
      AUTO_CONFIRM=1
      ;;
    *)
      ;;
  esac
done

# Confirmation logic
if [ "$AUTO_CONFIRM" -ne 1 ]; then
  echo -n "These verbs were generated from a ONEXPLAYER 2 PRO (8840u), I can't be sure it will work for you. USE ON YOUR OWN RISK!!! continue [y/N] " >&2
  read confirm
  if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo "Skip" >&2
    exit
  fi
else
  echo "Auto-confirmed with -y flag" >&2
fi

CONFIG="hda-verbs.conf"
DEVICE="/dev/snd/hwC1D0"

if [[ ! -f "$CONFIG" ]]; then
    echo "Config file not found: $CONFIG" >&2
    exit 3
fi

# Execute each verb line from config
time while read -r nid verb val; do
    [[ -z "$nid" || "$nid" == \#* ]] && continue
    hda-verb "$DEVICE" "$nid" "$verb" "$val" >/dev/null 2>&1
done < "$CONFIG"
