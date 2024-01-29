#!/bin/bash
set -euo pipefail
IFS=$' \n\t'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

function handle_file() {
    origin_dir="$2"
    origin_file="$1"
    dest_dir="$HOME/new_images/$(exiftool -q -model "$1")"
    dest_filename=${origin_file#"$origin_dir/"}
    dest_file="$dest_dir/$dest_filename"
    dest_actual_dir=$(dirname "$dest_file")

    # echo
    # echo $origin_dir
    # echo $origin_file
    # echo $dest_dir
    # echo $dest_filename
    # echo $dest_file
    # echo $dest_actual_dir

    mkdir -p "$dest_actual_dir"
    rsync -av "$origin_file" "$dest_file"

    # mkdir -p "$dest_dir"
    # cp "$"
}
# needs to be exported for use in find
# can only be used inside another bash instance
export -f handle_file

function handle_dir() {
    find "$1" -type f -exec bash -c "handle_file '{}' '$1'" \;
}
export -f handle_dir

# copy chrris images
# find . -name 'Christopher' -type d -exec bash -c "handle_dir '{}'" \;

# copy alexander images
find . -type f -execdir bash -c "handle_file '{}' ." \;
