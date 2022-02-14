#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo installing clang-format config
ln -fvs $DIR/.clang-format ~/.clang-format

echo installing gdb config
ln -fvs $DIR/.gdbinit ~/.gdbinit

echo installing git config
grep -E ' *path = .+/\gitconfig$' ~/.gitconfig > /dev/null || printf "[include]\n path = $DIR/gitconfig\n" >> ~/.gitconfig

echo installing inputrc config
ln -fvs $DIR/.inputrc ~/.inputrc

echo installing xfce config
ln -fvs $DIR/.Xmodmap ~/.Xmodmap
ln -fvs $DIR/user-dirs.dirs ~/.config/user-dirs.dirs
# create dump and dwn dirs
mkdir -vp ~/.dump
mkdir -vp ~/dwn

echo installing indentconfig config
cat <<EOF > ~/.indentconfig.yaml
paths:
  - $DIR/latexindent_config.yaml
EOF

echo installing bashrc
# only append sourcing when not already done
grep -E 'source .+/bashrc$' ~/.bashrc > /dev/null || echo "source $DIR/bashrc" >> ~/.bashrc

echo installing font
curl -o font.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
rm -r $HOME/.local/share/fonts || true
mkdir -vp $HOME/.local/share/fonts
mv -v font.zip $HOME/.local/share/fonts
cd $HOME/.local/share/fonts
unzip font.zip
rm -v font.zip
fc-cache -f -v

echo installing kitty config
rm -rvf ~/.config/kitty
mkdir -vp ~/.config/kitty
git clone https://github.com/dexpota/kitty-themes ~/.config/kitty
ln -fvs $DIR/kitty.conf ~/.config/kitty/kitty.conf

echo "All done! Have a nice day."
