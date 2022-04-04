#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# different configs for different systems
if [[ $1 == "laptop" ]]; then
    echo "installing laptop /etc/portage/make.conf"
    ln -fvs $DIR/etc_portage_make_laptop.conf /etc/portage/make.conf
elif [[ $1 == "desktop" ]]; then
    echo "installing desktop /etc/portage/make.conf"
    ln -fvs $DIR/etc_portage_make_desktop.conf /etc/portage/make.conf
else
    echo "error: no installation type cofigured"
    false
fi

echo "installing /etc/default/grub"
ln -fvs $DIR/etc_default_grub /etc/default/grub

echo "installing /usr/share/sddm/scripts/Xsetup"
ln -fvs $DIR/usr_share_sddm_scripts_Xsetup /usr/share/sddm/scripts/Xsetup

echo "installing /etc/portage/package.use"
ln -fvs $DIR/etc_portage_package.use /etc/portage/package.use

echo "installing /etc/modprobe.d/blacklist.conf"
ln -fvs $DIR/etc_modprobe.d_blacklist.conf /etc/modprobe.d/blacklist.conf

echo "All done! Have a nice day."

