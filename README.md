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

# Install Instructions
- push repos
- save game screenshots
- copy `/etc/NetworkManager/system-connections` into keepass db
- put keepass db on usb
- create firefox bookmarsk backup
- download endeavouros and put on usb
- copy files to backup drive
- say goodbye to your system for the last time

- install endeavour os with lan cable
- partitions:
    - 1024MiB  /efi fat32 boot
    - 2RAM      swap  swap
    - rest     /    ext4  root

- copy keepass files over
- `git clone https://github.com/christopher-besch/configs ~/.custom_configs`
- install config
- `sudo pacman -S xfce4-cpugraph-plugin xfce4-netload-plugin kitty gimp libreoffice-still-de kicad-library-3d kicad-library kicad strawberry audacity blender gthumb inkscape keepassxc thunderbird neovim obs-studio jdk-openjdk rawtherapee signal-desktop vlc tree exa docker docker-compose base-devel git python3 vim xclip python-pynvim libwacom xf86-input-wacom xournalpp`
- `yay mmv`

- install ssh priv and pub key from keepass db
- enable keepassxc browser integration for firefox
- enable keepassxc ssh agent integration
- `git remote set-url origin git@github.com:christopher-besch/configs.git` in `~/.custom_configs`

- install rustup (and rust and cargo)
- install nvm (and node and npm)
- install lvim (no for python dependencies; check for new ones in script)
- install NetworkManager files (set owner to root in `/etc/NetworkManager/system-connections`)
- `usermod -aG docker chris`
- `usermod -aG uucp chris`
- copy files from backup drive
- set display resolution/refresh rate (possibly multiple for different monitor setups)
- set background image in `/usr/share/endeavouros/backgrounds`, configure in xfce config and in `/etc/lightdm/slick-greeter.conf`
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

- config Firefox
- extensions:
    - https://addons.mozilla.org/en-US/firefox/addon/decentraleyes
    - https://addons.mozilla.org/en-US/firefox/addon/i-dont-care-about-cookies
    - https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser/
    - https://addons.mozilla.org/en-US/firefox/addon/ublock-origin
    - https://addons.mozilla.org/en-US/firefox/addon/youtube-recommended-videos
- delete cookies when firefox is closed
- don't clear history
- enable https only mode
- Firefox cookie / Decentraleyes exceptions:
    - github.com
    - keyhero.com
    - web.whatsapp.com
    - web.telegram.com
    - kuma.rasp01.fritz.box
    - mc.chris-besch.com
    - recipe.chris-besch.com
    - nextcloud.chris-besch.com
    - photo.chris-besch.com
    - firefly.chris-besch.com
- install bookmark backup
- keyword.enabled: https://chris-besch.com/articles/installing_gentoo/#firefox

- add email accounts to thunderbird
- add pgp keys
- config mail@chris-besch.com for pgp

- install minecraft

- TODO: nextcloud autofs config

- set wacom pen and tablet to mouse+keyboard in xournalpp
- disable pc speaker: https://wiki.archlinux.org/title/PC_speaker

# GDB Commands
- `tui enable`
- `target record-full`
- `record`
- `reverse-step`
- `reverse-next`
- clear screen: ctrl+l

# Blender Hotkeys
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

# Music Procedure
1. download music zip
2. extract into `[artist]/[album]`
3. convert covers to `cover.png`
4. `source ~/.custom_configs/music_scripts.sh`
5. check artist, album, title and track with `test_marwin .`
6. adjust with `eyeD3 --artist '[artist]' --album '[album]' *.mp3`
7. prettify title song by song (maybe use vi to batch edit titles)
8. `clean_music .`
9. create backup
10. `name_correct .`
11. fix errors manually
12. check all with `tree`
13. copy files into `/home/chris/files/music/data`
14. enable external access to Hetzner storage box
15. check with `rsync --dry-run --delete -avP . u370909@u370909.your-storagebox.de:/home/nextcloud_lfs/selchris_music` in `/home/chris/files/music`
16. `rsync --delete -avP . u370909@u370909.your-storagebox.de:/home/nextcloud_lfs/selchris_music` in `/home/chris/files/music`
17. disable external access to Hetzner storage box
18. `docker exec -ti --user www-data NCFrontend_chris_nextcloud /var/www/html/occ files:scan --all` on Hetzner server
19. rescan Music library
20. enjoy

# Images Procedure
1. copy images from the camera in the current directory (i.e. 104) to temp dir on pc
2. use new directory on camera (i.e. 105)
3. on pc delete bad images (keep as few as possible; imagine you were taking analogue photos—they didn't have many images for a single situation either)
4. move images to correct dir (select photographer for each image)
5. enable external access to Hetzner storage box
6. check with `rsync --dry-run --delete -avP . u370909@u370909.your-storagebox.de:/home/images` in `/home/chris/files/images/images`
7. `rsync --delete -avP . u370909@u370909.your-storagebox.de:/home/images` in `/home/chris/files/images/images`
8. disable external access to Hetzner storage box
9. rescan Photoprism library

# Screenshots Prodecure
1. `mogrify -format jpg *.png`
2. `rm *.png`
3. `exiftool '-EXIF:DateTimeOriginal<Filename' *`
4. `rm *.jpg_original`

# Other Useful Stuff
- `exiftool '-EXIF:DateTimeOriginal=2023-08-13-12-00' 001_{028..036}.jpg`

# Solve Issues with Pacman Keys on EndeavourOS
2. `sudo rm -r /etc/pacman.d/gnupg`
3. `sudo pacman-key --init`
4. `sudo pacman-key --populate archlinux endeavouros`
5. `sudo pacman -Syy archlinux-keyring endeavouros-keyring`

# KiCad Hotkeys
- repour: B
