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
- [Chris' Dotfiles (Looking for something aesthetic? Check his stuff out.)](https://github.com/TecCheck/dotfiles)
- [clang-format-configurator](https://zed0.co.uk/clang-format-configurator)
- [Pascal's Configs](https://github.com/pascal-kuschkowitz/bash)
- [inputrc for Humans](https://www.topbug.net/blog/2017/07/31/inputrc-for-humans)
- [.inputrc for vi](https://gist.github.com/markscottwright/bf81539661b84649ea7924790729d596)
- [Setup GitHub Verified Commits](https://gist.github.com/Beneboe/3183a8a9eb53439dbee07c90b344c77e)
- [Wacom](https://www.youtube.com/watch?v=dzplf-0RJDE)
- `ssh s_besch@i08fs1.informatik.kit.edu lp -d pool-sw1 -o sides=two-sided-long-edge < file.pdf`
- http://studscan.informatik.kit.edu with `ssh -C2qTnND 8080 i08fs1.informatik.kit.edu`

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

# Solve Issues with Pacman Keys on EndeavourOS
2. `sudo rm -r /etc/pacman.d/gnupg`
3. `sudo pacman-key --init`
4. `sudo pacman-key --populate archlinux endeavouros`
5. `sudo pacman -Syy archlinux-keyring endeavouros-keyring`

# KiCad Hotkeys
- repour: B

# Fixed Weird PDF
1. remove crop: `gs -o Kap\ A_\ Folien_Waermeschutz_fixed_size.pdf -sDEVICE=pdfwrite -dPDFFitPage -r300x300 -g2480x3507 Kap\ A_\ Folien_Waermeschutz.pdf`
2. rotate landscape pages: `pdftk Kap\ A_\ Folien_Waermeschutz_fixed_size.pdf cat 1-40 41left 42 43-53left 54-55 56left 57 58-59left 60 61-66left 67-end output Kap\ A_\ Folien_Waermeschutz_fixed_size_rotated.pdf`
3. turn into bitmap: `gimp Kap\ A_\ Folien_Waermeschutz_fixed_size_rotated.pdf` and export as `Kap A_ Folien_Waermeschutz_fixed_size_rotated_gimped.pdf`
4. compress: `pdfcomp Kap A_ Folien_Waermeschutz_fixed_size_rotated_gimped.pdf` aka `gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="comp_$file" "$file"`

# Revert Arch Grub Update
- [link](https://www.reddit.com/r/archlinux/comments/wx90x4/latest_grub_update_testing_repo_couldnt_boot)
- [without downgrade](https://forum.endeavouros.com/t/grub-2-2-06-r322-gd9b4638c5-1-wont-boot-and-goes-straight-to-the-bios-after-update/30653/60)

1. Make a Live USB with archlinux (or archlinux based) and boot on it
2. Mount your partitions (/, /home, /boot/efi... and so on)
3. Use arch-chroot to "connect" as root. From now on, it's like your on your PC, from the cli
4. Find the previous version number of grub by looking at the logs (grep -i upgrade /var/log/pacman.log | grep grub should do the trick)
5. Locate the corresponding archive in /var/cache/pacman/pkg/ (find /var/cache/pacman/pkg/ -iname "grub*")
6. Use pacman to downgrade (pacman -U /var/cache/pacman/pkg/grub-2:2... complete with the previous version number)
7. If not done automatically, grub-mkconfig -o /boot/grub/grub.cfg
8. Reboot

1. `grub-mkconfig -o /boot/grub/grub.cfg`
2. `grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=EndeavourOS-grub`

