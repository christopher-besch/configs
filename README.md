# Chris' Configs
The `install.sh` script symlinks the dotfiles in this directory to wherever they belong.
There's a server, a desktop and an IBM version.
The server version is basically a subset of all desktop configs that also work on an SSH server.
The IBM version is a subset of the desktop version.

# How to Cook Like I Do?
1. Fork this repo,
2. adjust the configs to your liking
3. and run `./install.sh server` or `./install.sh desktop`.
   (Warning: this script permanently overwrites your current configs.)

# Gentoo Config
The [`gentoo` subdirectory](gentoo) contains my Gentoo configs.
The same three-step plan applies to it, with an addition to the third:
You have to run the `install.sh` script with root privileges (with `sudo`).

# Resources
- [clang-format-configurator](https://zed0.co.uk/clang-format-configurator)
- [Pascal's Configs](https://github.com/pascal-kuschkowitz/bash)
- [inputrc for Humans](https://www.topbug.net/blog/2017/07/31/inputrc-for-humans)
- [.inputrc for vi](https://gist.github.com/markscottwright/bf81539661b84649ea7924790729d596)
- [Setup GitHub Verified Commits](https://gist.github.com/Beneboe/3183a8a9eb53439dbee07c90b344c77e)
- [Wacom](https://www.youtube.com/watch?v=dzplf-0RJDE)

# Install instructions
- [stuff missing]
- set display resolution/refresh rate (possibly multiple for different monitor setups)
- set background image
- panel:
    - Workspace Switcher
    - Window Buttons
    - Separator
    - Network Monitor (no text, select wifi card, values, colourise values)
    - CPU Graph
    - Status Tray Plugin
    - PulseAudio Plugin
    - Power Manager Plugin (show percentage)
    - Notification Plugin
    - Separator
    - DateTime
    - DateTime
- install `xfce4-cpugraph-plugin`, `xfce4-netload-plugin`
- disable screen saver
- disable raise windows when any mouse button is pressed
- key used to grab and move windows: None
- disable use mouse wheel on title bar to roll up the window
- disable use the mouse wheel on the desktop to switch workspaces
- disable shadows under dock windows
- xflock4 on Super+L
- xfce4-appfinder on Super+Tab
- on battery: blank after 10min., put to sleep after 15min., switch off after never, on inactivity reduce to 20%, reduce after 60sec.
- plugged in: never, never, never, never
- default terminal: kitty

# GDB commands
- `tui enable`
- `target record-full`
- `record`
- `reverse-step`
- `reverse-next`

# Blender hotkeys
- join objects: ctrl+j in object mode
- separate meshes: p in edit mode
- hide everything except for selected: shift+h
- show hidden objects: alt+h
- duplicate selected: shift+d
- select all linked : ctrl+l
- modifier for move (g), scale (s):
    - in one direction: x, y, z
    - in both other directions: shift+x, shift+y, shift+z
- all to same hight: s z 0

