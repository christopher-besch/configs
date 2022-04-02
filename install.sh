#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

echo installing clang-format config
ln -fvs $DIR/.clang-format ~/.clang-format

echo installing GDB config
ln -fvs $DIR/.gdbinit ~/.gdbinit

echo installing Git config
# only append include when not already done
grep -E ' *path = .+/\gitconfig$' ~/.gitconfig > /dev/null || printf "[include]\n path = $DIR/gitconfig\n" >> ~/.gitconfig

echo installing gpg config
ln -fvs $DIR/gpg-agent.conf ~/.gnupg/gpg-agent.conf

echo installing inputrc config
ln -fvs $DIR/.inputrc ~/.inputrc

echo installing Xfce config
ln -fvs $DIR/.Xmodmap ~/.Xmodmap
ln -fvs $DIR/user-dirs.dirs ~/.config/user-dirs.dirs
# create dump and dwn dirs
mkdir -vp ~/.dump
mkdir -vp ~/dwn

echo installing latexindent config
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

echo installing LunarVim config
mkdir -vp ~/.config/lvim
ln -fvs $DIR/config.lua ~/.config/lvim/config.lua

echo installing LunarVim German Spelling
# fixes a bug: https://github.com/LunarVim/LunarVim/issues/1445
mkdir -p ~/.local/share/lunarvim/site/spell
ln -fvs $DIR/vendor/de.utf-8.spl ~/.local/share/lunarvim/site/spell/de.utf-8.spl
ln -fvs $DIR/vendor/de.utf-8.sug ~/.local/share/lunarvim/site/spell/de.utf-8.sug

echo "All done! Have a nice day."

