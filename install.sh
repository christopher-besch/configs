#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

rm -v ~/.clang-format || true
ln -vs $DIR/.clang-format ~/.clang-format

rm -v ~/.gdbinit || true
ln -vs $DIR/.gdbinit ~/.gdbinit

rm -v ~/.gitconfig || true
ln -vs $DIR/.gitconfig ~/.gitconfig

rm -v ~/.inputrc || true
ln -vs $DIR/.inputrc ~/.inputrc

rm -v ~/.Xmodmap || true
ln -vs $DIR/.Xmodmap ~/.Xmodmap

rm -v ~/.indentconfig.yaml || true
cat <<EOF > ~/.indentconfig.yaml
paths:
  - $DIR/latexindent_config.yaml
EOF

# only append sourcing when not already done
grep -E 'source .+/\.bashrc$' ~/.bashrc > /dev/null || echo "source $DIR/.bashrc" >> ~/.bashrc
