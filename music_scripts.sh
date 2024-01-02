# important stuff
# - file_name
# - artist
# - album-artist none
# - total_tracks none
# - album
# - track
# - title
#
# singles:
# album: artist
# track: none
# name: only title

# upgrade commands
# id3convert

# borg commands
# docker run --rm -ti -v /home/chris/files/music:/music chrisbesch/borg2
# borg -r /music/repo rcreate --encryption=none
# TZ=Europe/Berlin && borg -r /music/repo/ create --info "{now}_existing_archive" /music/data
#
# docker run --rm -ti -v /home/chris/.ssh/chris_contabo01_music_borg:/ssh_priv_key:ro -v /home/chris/music:/music:ro -v /home/chris/backup/music_repo:/music_repo --entrypoint=bash chrisbesch/docker_borg_client
# borg -r "ssh://root@nextcloud.chris-besch.com/var/lib/borg_server/repos/music" check --rsh "ssh -i /ssh_priv_key -p 2845"
# borg -r "ssh://root@nextcloud.chris-besch.com/var/lib/borg_server/repos/music" transfer --other-repo /music_repo --dry-run --rsh "ssh -i /ssh_priv_key -p 2845"
# borg -r "ssh://root@nextcloud.chris-besch.com/var/lib/borg_server/repos/music" transfer --other-repo /music_repo --rsh "ssh -i /ssh_priv_key -p 2845"

# rip cd
# abcde -d /dev/sr0 -o 'mp3: -b 320'

# doesn't work with " in name
function get_raw() {
    find "$2" -type f -name '*.mp3' -printf 'exiftool -json "%p"' -printf " | jq .[0].$1\n" | sh
}
function get() {
    find "$2" -type f -name '*.mp3' -printf 'echo "%p" && exiftool -json "%p"' -printf " | jq .[0].$1\n" | sh
}

function test_artist() {
    echo '## artist ##' && get Artist "$1"
}
function test_album() {
    echo '## album ##' && get Album "$1"
}
function test_title() {
    echo '## title ##' && get Title "$1"
}
function test_track() {
    echo '## track ##' && get Track "$1"
}
function test_marwin() {
    test_artist "$1" && test_album "$1" && test_title "$1" && test_track "$1"
}

function jpg_to_png() {
    find $1 -name '*.jpg' -exec mogrify -format png {} \;
}

# function merge_discs_astroneer() {
#     for FILE in $1/*.mp3; do
#         ALBUM=$(get_raw Album "$FILE")
#         if [[ $ALBUM == '"Astroneer (original game soundtrack) Volume 2"' ]]; then
#             TRACK=$(get_raw Track "$FILE")
#             NEW_TRACK=$(($TRACK+26))
#             echo $FILE
#             eyeD3 --track $NEW_TRACK "$FILE"
#             # eyeD3 --album "Astroneer" "$FILE"
#         fi
#     done
# }

# function fix() {
#     find . -type f -name '*.mp3' -exec id3convert "{}" \;
#     find "$1" -type f -name '*.mp3' -printf 'eyeD3 --track $(exiftool -json "%p" | jq -r .[0].Track | python3 -c "print(int(input().split(\"/\")[0]))") "%p"\n' | sh
# }

# doesn't support " or ' in name
# function rename() {
#     # find . -name '*.mp3' -printf 'eyeD3 --title ' -printf '"' -printf '$(python3 -c \\"print(' -printf "'%f'" -printf '.split(' -printf "'.'" -printf ')[0])\\")' -printf '"' -printf ' "%p"\n' | sh
#     find $1 -name '*.mp3' -printf 'python3 -c "' -printf "print('%f'.split('.')[0])" -printf '" | eyeD3 --title "$(tee)" "%p"\n' | sh
# }

# apply correct track number
function retrack() {
    CNT=0
    for FILE in $(find $1 -name *.mp3); do
        CNT=$(($CNT+1))
        echo $CNT $FILE
        eyeD3 --track $CNT "$FILE"
    done
}

function retitle() {
    for FILE in $(find $1 -name *.mp3); do
        TITLE=$(basename $FILE .mp3)
        echo $FILE $TITLE
        eyeD3 --title "$TITLE" "$FILE"
    done
}

# apply correct file name
function name_correct() {
    find . -name '*.mp3' \
        -printf 'echo $(exiftool -json "%p" | jq -r .[0].Track | python3 -c "print(str(int(input())).rjust(3, \\"0\\"))") "-" ' \
        -printf '$(exiftool -json "%p" | jq -r .[0].Title) | ' \
        -printf 'mv "%p" "%h/$(tee).mp3" && ' \
        -printf 'echo "%p" \n' | \
            sh
}

function clean_music() {
    find "$1" -type f -name '*.mp3' -exec id3convert '{}' \;
    eyeD3 -r --album-artist '' "$1"
    eyeD3 -r --track-total 0 "$1"
    eyeD3 -r --composer '' "$1"
    eyeD3 -r --remove-all-images "$1"
}

# find . -name "- *.mp3" -printf 'echo "%f" | python3 -c "print(input()[2:])" | echo "./%f" "./$(tee)"\n' | sh

# do first:
# mmv '*_*' '#1 #2'
function lofi_album() {
    for DIR in *; do
        pushd "$DIR" > /dev/null
        for MP3 in *.mp3; do
            eyeD3 --album "$DIR" "$MP3"
        done
        popd > /dev/null
    done
}

function lofi_remove_spaces() {
    for DIR in *; do
        pushd "$DIR" > /dev/null
        while mmv '*_*' '#1 #2'; do
            true
        done
        popd > /dev/null
    done
}

function lofi_title() {
    for DIR in *; do
        pushd "$DIR" > /dev/null
        for MP3 in *.mp3; do
            eyeD3 --title "${MP3%'.mp3'}" "$MP3"
        done
        popd > /dev/null
    done
}

