#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

rm ~/.clang-format || true
ln -s $DIR/.clang-format ~/.clang-format

rm ~/.gdbinit || true
ln -s $DIR/.gdbinit ~/.gdbinit

rm ~/.gitconfig || true
ln -s $DIR/.gitconfig ~/.gitconfig

cat 'source "$HOME/files/installations/configs/.bashrc.sh"' >> ~/.bashrc
