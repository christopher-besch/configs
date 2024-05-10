# Install Procedure

## On Old Machine
- save game screenshots
- copy `/etc/NetworkManager/system-connections` into keepass db
- put keepass db on usb
- create firefox bookmarks backup
- download endeavouros and put on usb `sudo dd if=EndeavourOS_Gemini-2024.04.20.iso of=/dev/sda conv=fsync bs=4M status=progress`
    from [Kali USB Install](https://www.kali.org/docs/usb/live-usb-install-with-linux/#creating-a-bootable-kali-usb-drive-on-linux-dd-with-status)
- create new password
- push repos (don't forget `~/.custom_configs` and `~/.passwd`)
- copy files to backup drive
- say goodbye to your system for the last time

## On New Machine
- install endeavour os with lan cable
- partitions:
    - 1024MiB  /efi fat32 boot
    - 2RAM      swap  swap
    - rest     /    ext4  root
- enable luks encryption

- copy keepass files over
- `git clone https://github.com/christopher-besch/configs ~/.custom_configs`
- install config
- `sudo pacman -S xfce4-cpugraph-plugin xfce4-netload-plugin kitty gimp libreoffice-still-de kicad-library-3d kicad-library kicad strawberry audacity blender gthumb inkscape keepassxc thunderbird neovim obs-studio jdk-openjdk rawtherapee signal-desktop vlc tree exa docker docker-compose base-devel cmake git python3 vim xclip python-pynvim libwacom xf86-input-wacom xournalpp perl-image-exiftool bear gdb pdftk ghostscript avrdude avr-gcc avr-libc avr-gdb screen jq pdfgrep`
- `yay mmv`

- install ssh priv and pub key from keepass db
- enable keepassxc browser integration for firefox
- enable keepassxc ssh agent integration
- `git remote set-url origin git@github.com:christopher-besch/configs.git` in `~/.custom_configs`

- install rustup (and rust and cargo)
- install nvm (and node and npm)
- install lvim (no for python dependencies; check for new ones in script and add to pacman command above)
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
- Firefox cookie / I don't care about cookies exceptions:
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
    - gitlab-ext.iosb.fraunhofer.de
- install bookmark backup
- keyword.enabled: https://chris-besch.com/articles/installing_gentoo/#firefox

- add email accounts to thunderbird
- add pgp keys
- config mail@chris-besch.com for pgp

- install minecraft

- TODO: nextcloud autofs config

- set wacom pen and tablet to mouse+keyboard in xournalpp
- disable pc speaker: https://wiki.archlinux.org/title/PC_speaker

- set default file manager to `bash -c 'export str="%s" && kitty -d ${str#file://}'`
- add `192.168.188.50 kuma.rasp01.fritz.box` to `/etc/hosts`
