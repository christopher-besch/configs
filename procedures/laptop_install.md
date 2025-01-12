# Install Procedure

## On Old Machine
- save game screenshots
- copy `/etc/NetworkManager/system-connections` into keepass db
- create new laptop password
- put keepass db on usb
- create firefox bookmarks backup
- download endeavouros/Debian and put on usb `sudo dd if=EndeavourOS_Gemini-2024.04.20.iso of=/dev/sda conv=fsync bs=4M status=progress`
    from [Kali USB Install](https://www.kali.org/docs/usb/live-usb-install-with-linux/#creating-a-bootable-kali-usb-drive-on-linux-dd-with-status)
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
- `sudo pacman -S xfce4-cpugraph-plugin xfce4-netload-plugin kitty gimp libreoffice-still-de kicad-library-3d kicad-library kicad strawberry audacity blender gthumb inkscape keepassxc thunderbird neovim obs-studio jdk-openjdk rawtherapee signal-desktop vlc tree exa docker docker-compose base-devel cmake git python3 vim xclip python-pynvim libwacom xf86-input-wacom xournalpp perl-image-exiftool bear gdb pdftk ghostscript avrdude avr-gcc avr-libc avr-gdb screen jq pdfgrep wireshark-qt ripgrep ansible ansible-lint`
- `yay mmv`
- `sudo apt install keepassxc xournalpp git curl exa mmv thunderbird vlc strawberry rsync gthumb default-jdk ripgrep python3-pynvim xclip pdfgrep imagemagick gimp rawtherapee inkscape tree cups-pdf sqlite3-tools gdb ansible ansible-lint bear xxd fonts-recommended`

- install ssh priv and pub key from keepass db
- enable keepassxc browser integration for firefox
- enable keepassxc ssh agent integration
- `git remote set-url origin git@github.com:christopher-besch/configs.git` in `~/.custom_configs`
- `git clone git@github.com:christopher-besch/passwd ~/.passwd`

- copy files from backup drive
- install rustup (and rust and cargo)
- install nvm
- `nvm install --lts`
- build and install neovim from source
- install lvim (no for python dependencies; check for new ones in script and add to pacman command above)
- install NetworkManager files (set owner to root in `/etc/NetworkManager/system-connections`)
- `sudo usermod -aG docker chris`
- `sudo usermod -aG uucp chris`
- set display resolution/refresh rate (possibly multiple for different monitor setups)

- `gsettings set org.gnome.settings-daemon.plugins.power idle-brightness 100`

```
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>F1']" &&
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>F2']" &&
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>F3']" &&
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>F4']" &&
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>F5']" &&
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>F6']"
```
- AppIndicator and KStatusNotifierItem Support
- Just Perfection
- auto move windows

- install signal with keyfile in proper location: `/etc/apt/keyrings`

# Firefox
- extensions:
    - https://addons.mozilla.org/en-US/firefox/addon/decentraleyes
    - https://addons.mozilla.org/en-US/firefox/addon/i-dont-care-about-cookies
    - https://addons.mozilla.org/en-US/firefox/addon/keepassxc-browser
    - https://addons.mozilla.org/en-US/firefox/addon/ublock-origin
    - https://addons.mozilla.org/en-US/firefox/addon/youtube-recommended-videos
    - https://addons.mozilla.org/en-US/firefox/addon/tabliss
- duckduckgo as search
- strict privacy
- delete cookies when firefox is closed
- don't clear history
- enable https only mode
- Firefox cookie / I don't care about cookies exceptions:
    - github.com
    - gitlab-ext.iosb.fraunhofer.de
    - keyhero.com
    - web.whatsapp.com
    - web.telegram.com
    - web.telegram.org
    - kuma.rasp01.fritz.box
    - mc.chris-besch.com
    - recipe.chris-besch.com
    - nextcloud.chris-besch.com
    - photo.chris-besch.com
    - firefly.chris-besch.com
    - discord.com
- install bookmark backup
- keyword.enabled: false https://chris-besch.com/articles/installing_gentoo/#firefox
- pdfjs.defaultZoomValue: page-fit: https://support.mozilla.org/en-US/questions/1074524

# Thunderbird
- add email accounts
- disable compose messages in html format
- add pgp keys to
- config mail@chris-besch.com for pgp
- add nextcloud address book using a new nextcloud app password

- install minecraft

- set wacom pen and tablet to mouse+keyboard in xournalpp
- set xournalpp view -> toolbars -> Chris Toolbar
- set xournalpp journal -> configure page template
- xournal edit -> preferences -> stylus -> button 1 vertical space, button 2 eraser
- gnome map wacom buttons: ctrl-shift-p ctrl-z ctrl-shift-h ctrl-shift-r

- set default file manager to `bash -c 'export str="%s" && kitty -d ${str#file://}'`
- add `192.168.188.50 kuma.rasp01.fritz.box` to `/etc/hosts`

# XFCE Settings
- appearance:
    - choose arc theme
- desktop:
    - set background image in settings
    - icon type: none
- panel:
    - Workspace Switcher
    - Window Buttons
    - Separator (expand, transparent)
    - Network Monitor (no text, no text to display, select wifi card, values, colourise values)
    - CPU Graph (Mode Disabled)
    - Status Tray Plugin
    - PulseAudio Plugin
    - Power Manager Plugin (show percentage)
    - Notification Plugin
    - Separator (dont't expand, transparent)
    - DateTime (Time only)
    - DateTime (Date only)
- xfce screensaver:
    - disable screen saver
- window manager tweaks
    - disable raise windows when any mouse button is pressed
    - key used to grab and move windows: None
    - disable use mouse wheel on title bar to roll up the window
    - disable use the mouse wheel on the desktop to switch workspaces
    - disable shadows under dock windows
- keyboard:
    - xflock4 on Super+L
    - xfce4-appfinder on Super+Tab
- power manager:
    - battery system sleep mode: suspend, never
    - plug system sleep mode: suspend, never
    - battery laptop lid: suspend
    - plug laptop lid: suspend
    - on battery: blank after 10min., put to sleep after 15min., switch off after never, on inactivity reduce to 20%, reduce after 60sec.
    - plugged in: never, never, never, never
- default applications
    - default terminal: kitty
