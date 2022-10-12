#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

#########################################################
# setup wacom Wacom Intuos S for drawing with Xournal++ #
#########################################################

# xsetwacom --list devices
STYLUS=18
PAD=19

# set draw area for 1920:1080 screen
xsetwacom --set $STYLUS Area 0 0 15200 8550

# press -> left click
xsetwacom --set $STYLUS Button 1 1
# lower stylus button -> left click
xsetwacom --set $STYLUS Button 2 1
# upper stylus button -> middle click -> pan (you might have to tell Xournal++ that the stylus is a "mouse", not a "pen")
xsetwacom --set $STYLUS Button 3 2

# 1 -> use pen
xsetwacom --set $PAD Button 1 "key shift ctrl p"
# 2 -> use eraser
xsetwacom --set $PAD Button 2 "key shift ctrl e"
# 3 -> select region
xsetwacom --set $PAD Button 3 "key shift ctrl g"

