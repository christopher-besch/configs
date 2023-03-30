#!/bin/bash

function is_git() {
    for DIR in $(find $1 -name '.git' -type d); do
        pushd $DIR >/dev/null
        git remote 2>/dev/null | grep "origin" >/dev/null && echo "$DIR/.."
        popd >/dev/null
    done
}
