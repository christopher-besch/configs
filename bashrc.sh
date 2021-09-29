#!/bin/bash

# HISTSIZE=100000
# HISTFILESIZE=100000

# ulimit -c unlimited

alias please=sudo
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
# alias bat=batcat
alias py=python3
alias icat='kitty +kitten icat'
alias vi='lvim'
export EDITOR='lvim'
alias chmod='chmod --preserve-root'

alias ls='exa --icons --group-directories-first'
alias l='echo "Prepare for unforeseen consequencesλ"'
alias ll='exa --icons --group-directories-first -alF'
alias la='exa --icons --group-directories-first -a'

# move through folders with j and k
function j() {
    if [ "$#" -ne 1 ]; then
        echo "target folder must be given"
        return 1
    fi
    pushd "$1" > /dev/null
    return $?
}
function k() {
    popd > /dev/null
    return $?
}

function mkcd() {
    mkdir "$1"
    cd "$1"
    return $?
}

# function pdfcomp() {
#     for file in "$@"; do
#         gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="comp_$file" "$file"
#     done
#     return $?
# }

# function ocrde() {
#     for file in "$@"; do
#         ocrmypdf --language deu "$file" "$file"
#     done
#     return $?
# }
# function ocren() {
#     for file in "$@"; do
#         ocrmypdf --language eng "$file" "$file"
#     done
#     return $?
# }
# function ocrdeen() {
#     for file in "$@"; do
#         ocrmypdf --language eng+deu "$file" "$file"
#     done
#     return $?
# }

# function topdf() {
#     for file in "$@"; do
#         echo "converting $file"
#         unoconv -f pdf --export=ExportFormFields=false "$file"
#     done
#     return $?
# }

# function totxt() {
#     for file in "$@"; do
#         echo "converting $file"
#         pdftotext -layout "$file"
#     done
#     return $?
# }

# function find_empty() {
#     IFS=$'\t\n'
#     for folder in $(find . -mindepth 1 -type d | grep -P -v ".*/\..*"); do
#         if [[ ! $(ls -A $folder) ]]; then
#             echo $folder
#         fi
#     done 
#     IFS=$' \t\n'
#     return $?
# }

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    # get exit code
    local EXIT="$?"

    if [ $EXIT != 0 ]; then
        # red when failed
        # PS1+="${txtred}\w ${txtrst}"
        PS1="\[\033[01;31m\]\w \[\033[0m\]λ "
    else
        # PS1+="${txtgrn}\w ${txtrst}"
        PS1="\[\033[01;32m\]\w \[\033[0m\]λ "
    fi

    return $EXIT
}
