# Blu-ray Rip Procedure

# Installations
- [Flash Blu-ray player](https://forum.makemkv.com/forum/viewtopic.php?f=16&t=19634) with [SDFtool Flasher](https://forum.makemkv.com/forum/viewtopic.php?f=16&t=22896)
- [install makemkv](https://forum.makemkv.com/forum/viewtopic.php?f=3&t=224) [beta key](https://forum.makemkv.com/forum/viewtopic.php?t=1053)
- install handbrake
- install handbrake_chris_1080p.json 

# Procedure
- rip Blu-ray with makemkv (only copy the relevant tracks)

- `rsync --dry-run --exclude README.md --exclude makemkv --delete -avP . u370909@u370909.your-storagebox.de:/home/jelly_media/`
