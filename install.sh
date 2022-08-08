#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

# determine installing type
if [[ -z ${1+x} ]]; then
    echo "installation type required"
    echo "use 'server' or 'desktop'"
    exit 1
else
    if [[ $1 == "server" ]]; then
        INSTALL_TYPE="server"
    elif [[ $1 == "desktop" ]]; then
        INSTALL_TYPE="desktop"
    else
        echo "invalid installation type: $1"
        echo "use 'server' or 'desktop'"
        exit 1
    fi
fi
echo "### installing chris' config for type: $INSTALL_TYPE ###"


###########################
# both desktop and server #
###########################

echo
echo "installing GDB config"
ln -fvs $DIR/.gdbinit ~/.gdbinit

echo
echo "installing inputrc config"
ln -fvs $DIR/.inputrc ~/.inputrc

echo
echo "installing bashrc"
# only append sourcing when not already done
grep -E '^source .+/bashrc_(desktop|server)$' ~/.bashrc || echo "source $DIR/bashrc_$INSTALL_TYPE" >> ~/.bashrc

########################
# only desktop version #
########################

if [[ $INSTALL_TYPE == "desktop" ]]; then
    echo
    echo "installing clang-format config"
    ln -fvs $DIR/.clang-format ~/.clang-format

    echo
    echo "installing Git config"
    # only append include when not already done
    grep -E ' *path = .+/\gitconfig$' ~/.gitconfig > /dev/null || printf "[include]\n path = $DIR/gitconfig\n" >> ~/.gitconfig

    echo
    echo "installing gpg config"
    mkdir -p ~/.gnupg
    ln -fvs $DIR/gpg-agent.conf ~/.gnupg/gpg-agent.conf

    echo
    echo "installing Xfce config"
    mkdir -p ~/.config
    ln -fvs $DIR/user-dirs.dirs ~/.config/user-dirs.dirs
    # create dump and dwn dirs
    mkdir -vp ~/.dump
    mkdir -vp ~/dwn

    echo
    echo "installing latexindent config"
    cat <<EOF > ~/.indentconfig.yaml
paths:
  - $DIR/latexindent_config.yaml
EOF

    echo
    echo "installing font"
    curl -o font.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
    rm -r $HOME/.local/share/fonts || true
    mkdir -vp $HOME/.local/share/fonts
    mv -v font.zip $HOME/.local/share/fonts
    cd $HOME/.local/share/fonts
    unzip font.zip
    rm -v font.zip
    fc-cache -f -v

    echo
    echo "installing kitty config"
    rm -rvf ~/.config/kitty
    mkdir -vp ~/.config/kitty
    git clone https://github.com/dexpota/kitty-themes ~/.config/kitty
    ln -fvs $DIR/kitty.conf ~/.config/kitty/kitty.conf

    echo
    echo "installing LunarVim config"
    mkdir -vp ~/.config/lvim
    ln -fvs $DIR/config.lua ~/.config/lvim/config.lua

    echo
    echo "installing LunarVim German Spelling"
    # fixes a bug: https://github.com/LunarVim/LunarVim/issues/1445
    mkdir -p ~/.local/share/lunarvim/site/spell
    ln -fvs $DIR/vendor/de.utf-8.spl ~/.local/share/lunarvim/site/spell/de.utf-8.spl
    ln -fvs $DIR/vendor/de.utf-8.sug ~/.local/share/lunarvim/site/spell/de.utf-8.sug

    echo
    echo "installing custom keyboard layout; please enter sudo password"
    sudo ln -fvs $DIR/chris_keyboard /usr/share/X11/xkb/symbols/chris_keyboard
    setxkbmap chris_keyboard
fi

echo
echo "All done! Have a nice day."
exit 0

