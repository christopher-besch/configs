#!/bin/bash

HISTSIZE=1000000
HISTFILESIZE=1000000
force_color_prompt=yes

alias please=sudo
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bat=batcat
alias py=python3
alias icat='kitty +kitten icat'
alias vi='nvim'
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

function pdfcomp() {
    for file in "$@"; do
        gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile="comp_$file" "$file"
    done
    return $?
}

function ocrde() {
    for file in "$@"; do
        ocrmypdf --language deu "$file" "$file"
    done
    return $?
}
function ocren() {
    for file in "$@"; do
        ocrmypdf --language eng "$file" "$file"
    done
    return $?
}
function ocrdeen() {
    for file in "$@"; do
        ocrmypdf --language eng+deu "$file" "$file"
    done
    return $?
}

function topdf() {
    for file in "$@"; do
        echo "converting $file"
        unoconv -f pdf --export=ExportFormFields=false "$file"
    done
    return $?
}

function totxt() {
    for file in "$@"; do
        echo "converting $file"
	pdftotext -layout "$file"
    done
    return $?
}

function find_empty() {
    IFS=$'\t\n'
    for folder in $(find . -mindepth 1 -type d | grep -P -v ".*/\..*"); do
        if [[ ! $(ls -A $folder) ]]; then
            echo $folder
        fi
    done 
    IFS=$' \t\n'
    return $?
}

PROMPT_COMMAND=__prompt_command
__prompt_command() {
    # get exit code
    local EXIT="$?"
    PS1=""

    txtblk='\e[0;30m' # Black - Regular
    txtred='\e[0;31m' # Red
    txtgrn='\e[0;32m' # Green
    txtylw='\e[0;33m' # Yellow
    txtblu='\e[0;34m' # Blue
    txtpur='\e[0;35m' # Purple
    txtcyn='\e[0;36m' # Cyan
    txtwht='\e[0;37m' # White
    bldblk='\e[1;30m' # Black - Bold
    bldred='\e[1;31m' # Red
    bldgrn='\e[1;32m' # Green
    bldylw='\e[1;33m' # Yellow
    bldblu='\e[1;34m' # Blue
    bldpur='\e[1;35m' # Purple
    bldcyn='\e[1;36m' # Cyan
    bldwht='\e[1;37m' # White
    unkblk='\e[4;30m' # Black - Underline
    undred='\e[4;31m' # Red
    undgrn='\e[4;32m' # Green
    undylw='\e[4;33m' # Yellow
    undblu='\e[4;34m' # Blue
    undpur='\e[4;35m' # Purple
    undcyn='\e[4;36m' # Cyan
    undwht='\e[4;37m' # White
    bakblk='\e[40m'   # Black - Background
    bakred='\e[41m'   # Red
    bakgrn='\e[42m'   # Green
    bakylw='\e[43m'   # Yellow
    bakblu='\e[44m'   # Blue
    bakpur='\e[45m'   # Purple
    bakcyn='\e[46m'   # Cyan
    bakwht='\e[47m'   # White
    txtrst='\e[0m'    # Text Reset


    if [ $EXIT != 0 ]; then
        # red when failed
        PS1+="${txtred}\w ${txtrst}"
    else
        PS1+="${txtgrn}\w ${txtrst}"
    fi

    PS1+="λ "
    return $?
}

