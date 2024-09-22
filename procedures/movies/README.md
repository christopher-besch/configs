# Blu-ray/DVD Rip Procedure

# Installations
- [Flash Blu-ray player](https://forum.makemkv.com/forum/viewtopic.php?f=16&t=19634) with [SDFtool Flasher](https://forum.makemkv.com/forum/viewtopic.php?f=16&t=22896)
- [install makemkv](https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224) [beta key](https://forum.makemkv.com/forum/viewtopic.php?t=1053)
- install handbrake
- install handbrake presets in this directory

# Procedure
- rip Blu-ray with makemkv (only copy the relevant tracks—that's usually the biggest track)
- open the mkv in handbrake, use appropriate preset, choose soundtracks and subtitles (one per language)
- name [movies](https://jellyfin.org/docs/general/server/media/movies) and [shows](https://jellyfin.org/docs/general/server/media/shows)
- enable hetzner storage box network access and ssh
- `rsync --dry-run --exclude README.md --exclude makemkv --delete -avP . u370909@u370909.your-storagebox.de:/home/jelly_media/` (remove `--dry-run`)
- disable hetzner storage box network access and ssh
