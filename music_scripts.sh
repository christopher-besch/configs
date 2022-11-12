# important stuff
# - file_name
# - artist
# - album-artist none
# - total_tracks none
# - album
# - track
# - title

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
function test() {
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
    for FILE in $1/*.mp3; do
        CNT=$(($CNT+1))
        echo $CNT $FILE
        eyeD3 --track $CNT "$FILE"
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

# find . -name "- *.mp3" -printf 'echo "%f" | python3 -c "print(input()[2:])" | echo "./%f" "./$(tee)"\n' | sh

