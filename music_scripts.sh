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
#
# use: 
# eyeD3 -r --rename '0$track:num - $title' .

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
    for FILE in $(find $1 -name '*.mp3'); do
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

function clean_music() {
    eyeD3 --to-v2.4 -r .
    # eyeD3 -r --album-artist '' "$1"
    eyeD3 -r --track-total 0 "$1"
    # eyeD3 -r --composer '' "$1"
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

# RMX3085L1:/storage/self/primary/Music/SambaPlayerCache/SCHIFFCHEN/music/lofi $ ls -R
# .:
# casiio  dryhope  kupla  mell_o  mondo_loops  s_n_u_g  spencer_hunt  tabal

# ./casiio:
# Casiio-Affection.mp3  Casiio_x_DontCry-Isolated.mp3       Casiio_x_Sleepermane-Distant_Blue.mp3    Casiio_x_Sleepermane-Particles.mp3   Casiio_x_Sleepermane-Wetlands.mp3
# Casiio-Back_Home.mp3  Casiio_x_Sleepermane-Afterglow.mp3  Casiio_x_Sleepermane-Lagoon.mp3          Casiio_x_Sleepermane-Phantasm.mp3    Casiio_x_Sleepermane-Wishing_Well.mp3
# Casiio-Harmonies.mp3  Casiio_x_Sleepermane-Atoms.mp3      Casiio_x_Sleepermane-Lightning_Bugs.mp3  Casiio_x_Sleepermane-Prisms.mp3      Casiio_x_Sleepermane_x_ODYSSEE-Suntai.mp3
# Casiio-Lush.mp3       Casiio_x_Sleepermane-Bamboo.mp3     Casiio_x_Sleepermane-Luna.mp3            Casiio_x_Sleepermane-Returnal.mp3    Casiio_x_Sleepermane_x_Sling_Dilly-Atlantis.mp3
# Casiio-Stray.mp3      Casiio_x_Sleepermane-Cascades.mp3   Casiio_x_Sleepermane-Magenta.mp3         Casiio_x_Sleepermane-Signals.mp3
# Casiio-To_see.mp3     Casiio_x_Sleepermane-Cycles.mp3     Casiio_x_Sleepermane-Maya.mp3            Casiio_x_Sleepermane-Surfaced.mp3
# Casiio-Wondering.mp3  Casiio_x_Sleepermane-Depths.mp3     Casiio_x_Sleepermane-Mockingbird.mp3     Casiio_x_Sleepermane-Underneath.mp3

# ./dryhope:
# Dryhope-Wander.mp3  dryhope-Childhood_Home.mp3  dryhope-Down_River.mp3   dryhope-Gravity.mp3       dryhope-No_Secrets.mp3  dryhope-Shade.mp3    dryhope-Steps.mp3    dryhope-somewhere_else.mp3
# dryhope-Amber.mp3   dryhope-Contrasts.mp3       dryhope-First_Light.mp3  dryhope-Higher_State.mp3  dryhope-Quetzal.mp3     dryhope-Someday.mp3  dryhope-Voyager.mp3  dryhope_x_dontcry-Evoke.mp3

# ./kupla:
# Kupla-A_Waltz_for_My_Best_Friend.mp3  Kupla-Heroes.mp3           Kupla-Melody_Mountain.mp3  Kupla-Orion.mp3              Kupla-Sleepy_Little_One.mp3    Kupla-Twilight.mp3
# Kupla-Castles_in_the_Snow.mp3         Kupla-In_Your_Eyes.mp3     Kupla-Memory_of_You.mp3    Kupla-Owls_of_the_Night.mp3  Kupla-Soft_to_Touch.mp3        Kupla-Under_the_Bridge.mp3
# Kupla-Dew.mp3                         Kupla-Kingdom_in_Blue.mp3  Kupla-Microscopic.mp3      Kupla-Purple_Vision.mp3      Kupla-Sunray.mp3               Kupla-Valentine.mp3
# Kupla-Distant_Lands.mp3               Kupla-Last_Walk.mp3        Kupla-Mycelium.mp3         Kupla-Roots.mp3              Kupla-Sylvan.mp3               Kupla-Valley_of_Hope.mp3
# Kupla-Eons.mp3                        Kupla-Lavender.mp3         Kupla-Natural_Ways.mp3     Kupla-Safe_Haven.mp3         Kupla-Tender_Souls.mp3         Kupla-Weightless.mp3
# Kupla-Fairies.mp3                     Kupla-Magic.mp3            Kupla-Orchid.mp3           Kupla-Serenity.mp3           Kupla-Those_Were_the_Days.mp3

# ./mell_o:
# mell-o-Alder.mp3           mell-o_x_Ambulo-Afloat_Again.mp3        mell-o_x_Ambulo-Drift_Away.mp3  mell-o_x_Ambulo-Solace.mp3          mell-o_x_mtch.-Currents.mp3
# mell-o-Away_From_Home.mp3  mell-o_x_Ambulo-Breathe.mp3             mell-o_x_Ambulo-Epilogue.mp3    mell-o_x_Ambulo-Stay_the_Same.mp3   mell-o_x_no_one_s_perfect-Forest_Trails.mp3
# mell-o-Clocks.mp3          mell-o_x_Ambulo-Childhood_Memories.mp3  mell-o_x_Ambulo-Gloom.mp3       mell-o_x_Osaki-Northern_Lights.mp3
# mell-o-Nova.mp3            mell-o_x_Ambulo-Dozing_Off.mp3          mell-o_x_Ambulo-Passage.mp3     mell-o_x_Phlocalyst-Nautilus.mp3

# ./mondo_loops:
# Mondo_Loops-Wandering_Another_World.mp3

# ./s_n_u_g:
# S_N_U_G-Another_Era.mp3    S_N_U_G-Haze.mp3          S_N_U_G_x_Dimension_32-fireflies.mp3      S_N_U_G_x_Mondo_Loops-mahogany.mp3     S_N_U_G_x_Nuver-Paths.mp3
# S_N_U_G-At_Ease.mp3        S_N_U_G-Illusion.mp3      S_N_U_G_x_Enluv-Circadian.mp3             S_N_U_G_x_Nuver-After_Dark.mp3         S_N_U_G_x_Nuver-Rooftop_Conversations.mp3
# S_N_U_G-Blankets.mp3       S_N_U_G-Lucidity.mp3      S_N_U_G_x_Jordy_Chandra-Late_Return.mp3   S_N_U_G_x_Nuver-Alaska.mp3             S_N_U_G_x_Nuver_x_Jordy_Chandra-Nova.mp3
# S_N_U_G-Dreams_of_You.mp3  S_N_U_G-Lustre.mp3        S_N_U_G_x_Jordy_Chandra-Snooze.mp3        S_N_U_G_x_Nuver-Dazed.mp3              S_N_U_G_x_Nuver_x_Mondo_Loops-Horizons.mp3
# S_N_U_G-Equinox.mp3        S_N_U_G-Missing_You.mp3   S_N_U_G_x_Kainbeats-Puddles.mp3           S_N_U_G_x_Nuver-Frost.mp3              S_N_U_G_x_Nuver_x_Project_AER-Afloat.mp3
# S_N_U_G-Evenings.mp3       S_N_U_G-Purple_Skies.mp3  S_N_U_G_x_Mondo_Loops-Dusk.mp3            S_N_U_G_x_Nuver-It_s_Getting_Late.mp3  S_N_U_G_x_Nuver_x_Sitting_Duck-Lighthouse.mp3
# S_N_U_G-Fading_Mist.mp3    S_N_U_G-Stargazing.mp3    S_N_U_G_x_Mondo_Loops-New_Beginnings.mp3  S_N_U_G_x_Nuver-Moonscapes.mp3         S_N_U_G_x_Spencer_Hunt-Balcony_Nights.mp3
# S_N_U_G-Findings.mp3       S_N_U_G-Warm_Meadows.mp3  S_N_U_G_x_Mondo_Loops-Night_Coffee.mp3    S_N_U_G_x_Nuver-Nightfall.mp3

# ./spencer_hunt:
# Spencer_Hunt-Moonlight.mp3

# ./tabal:
# TABAL-An_Unknown_Journey.mp3  TABAL_x_Tah.-Menthol_Breathing.mp3

