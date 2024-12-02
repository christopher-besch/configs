#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"


# determine installing type
if [[ -z ${1+x} ]]; then
    echo "installation type required"
    echo "use 'server', 'desktop' or 'ibm'"
    exit 1
else
    if [[ $1 == "server" ]]; then
        INSTALL_TYPE="server"
    elif [[ $1 == "desktop" ]]; then
        INSTALL_TYPE="desktop"
    elif [[ $1 == "ibm" ]]; then
        INSTALL_TYPE="ibm"
    else
        echo "invalid installation type: $1"
        echo "use 'server', 'desktop' or 'ibm'"
        exit 1
    fi
fi
echo "### installing chris' config for type: $INSTALL_TYPE ###"


###########################
# desktop, server and ibm #
###########################
echo
echo "installing inputrc config"
ln -fvs $DIR/.inputrc ~/.inputrc

echo
echo "installing bashrc"
# only append sourcing when not already done
grep -E '^source .+/bashrc_(desktop|server)$' ~/.bashrc || echo "source $DIR/bashrc_$INSTALL_TYPE" >> ~/.bashrc

################
# only desktop #
################
if [[ $INSTALL_TYPE == "desktop" ]]; then
    echo
    echo "installing ssh config"
    mkdir -vp ~/.ssh
    ln -fvs $DIR/ssh_config ~/.ssh/config

    echo
    echo "installing xournalpp config"
    mkdir -vp ~/.config/xournalpp
    ln -fvs $DIR/toolbar.ini "$HOME/.config/xournalpp/toolbar.ini"
    ln -fvs $DIR/palette.gpl "$HOME/.config/xournalpp/palette.gpl"

    # echo
    # echo "installing wacom scripts"
    # sudo ln -fvs $DIR/wacom/wacom_normal "/usr/local/bin/wacom_normal"
    # sudo ln -fvs $DIR/wacom/wacom_xournal "/usr/local/bin/wacom_xournal"
    # sudo ln -fvs $DIR/wacom/wacom_inkscape "/usr/local/bin/wacom_inkscape"
    # mkdir -p "$HOME/.local/share/applications"
    # ln -fvs $DIR/wacom/wacom_xournal.desktop "$HOME/.local/share/applications/wacom_xournal.desktop"
    # ln -fvs $DIR/wacom/wacom_inkscape.desktop "$HOME/.local/share/applications/wacom_inkscape.desktop"
fi

########################
# only desktop and ibm #
########################
if [[ $INSTALL_TYPE == "desktop" || $INSTALL_TYPE == "ibm" ]]; then
    echo
    echo "installing GDB config"
    ln -fvs $DIR/.gdbinit ~/.gdbinit

    echo
    echo "installing LunarVim config"
    mkdir -vp ~/.config/lvim ~/.config/lvim/{lsp-settings,spell}
    ln -fvs $DIR/config.lua ~/.config/lvim/config.lua
    ln -fvs $DIR/eclipse_formatter.xml ~/.config/lvim/eclipse_formatter.xml
    ln -fvs $DIR/jdtls.json ~/.config/lvim/lsp-settings/jdtls.json


    echo
    echo "installing clang-format config"
    ln -fvs $DIR/.clang-format ~/.clang-format

    echo
    echo "installing Xfce config"
    mkdir -p ~/.config
    ln -fvs $DIR/user-dirs.dirs ~/.config/user-dirs.dirs
    # create dwn dirs
    mkdir -vp ~/dwn

    echo
    echo "installing latexindent config"
    cat <<EOF > ~/.indentconfig.yaml
paths:
  - $DIR/latexindent_config.yaml
EOF

    echo
    echo "installing font"
    curl -o font.zip -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    rm -r "$HOME/.local/share/fonts/JetBrains Mono" || true
    mkdir -vp "$HOME/.local/share/fonts/JetBrains Mono"
    mv -v font.zip "$HOME/.local/share/fonts/JetBrains Mono"
    cd "$HOME/.local/share/fonts/JetBrains Mono"
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
    echo "installing Git config"
    # only append include when not already done
    grep -E ' *path = .+/gitconfig_ibm$' ~/.gitconfig > /dev/null || cat >> ~/.gitconfig <<EOL

[credential]
    helper = store
[pull]
    rebase = true
[init]
    defaultBranch = main
[gpg]
    format = ssh
[commit]
    gpgsign = true
[tag]
    gpgsign = true

[core]
    attributesfile = ~/.gitattributes

[diff "pdfdiff"]
    command = diffpdf

# copied from: https://stackoverflow.com/questions/1838873/visualizing-branch-topology-in-git/34467298#34467298
[alias]
    lg = lg1
    lg1 = lg1-specific --all
    lg2 = lg2-specific --all
    lg3 = lg3-specific --all

    lg1-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'
    lg2-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
    lg3-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'

    pushf = push --force-with-lease

# configs for different remotes
[includeIf "hasconfig:remote.*.url:git@github.com:*/**"]
    path = $DIR/gitconfig_github
[includeIf "hasconfig:remote.*.url:git@gitlab-ext.iosb.fraunhofer.de:*/**"]
    path = $DIR/gitconfig_fraunhofer
[includeIf "hasconfig:remote.*.url:git@github.ibmgcloud.net:*/**"]
    path = $DIR/gitconfig_ibm
EOL
    
    ln -fvs $DIR/gitattributes ~/.gitattributes

    echo
    echo "installing custom keyboard layout"
    # you might need to adjust /etc/default/keyboard
    sudo ln -fvs $DIR/chris_keyboard /usr/share/X11/xkb/symbols/chris_keyboard
    cat <<EOF
Add this to /usr/share/X11/xkb/rules/evdev.xml
    <layout>
      <configItem>
        <name>chris_keyboard</name>
        <!-- Keyboard indicator for English layouts -->
        <shortDescription>chris_keyboard</shortDescription>
        <description>English (GB, with Chris' extra keys)</description>
        <countryList>
          <iso3166Id>GB</iso3166Id>
        </countryList>
        <languageList>
          <iso639Id>eng</iso639Id>
        </languageList>
      </configItem>
    </layout>

Add this to /usr/share/X11/xkb/rules/evdev.lst
  chris_keyboard  English (GB, with Chris' extra keys)

EOF
fi

echo
echo "All done! Have a nice day."
exit 0

