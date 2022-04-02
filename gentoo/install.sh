#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo installing /etc/default/grub
ln -fvs $DIR/etc_default_grub /etc/default/grub

echo installing /usr/share/sddm/scripts/Xsetup
ln -fvs $DIR/usr_share_sddm_scripts_Xsetup /usr/share/sddm/scripts/Xsetup

echo installing /etc/portage/make.conf
ln -fvs $DIR/etc_portage_make.conf /etc/portage/make.conf

echo installing /etc/portage/package.use
ln -fvs $DIR/etc_portage_package.use /etc/portage/package.use

echo "All done! Have a nice day."

