# Images Procedure
1. copy images from the camera in the current directory (i.e. 104) to temp dir on pc
2. use new directory on camera (i.e. 105)
3. on pc delete bad images (keep as few as possible; imagine you were taking analogue photos—they didn't have many images for a single situation either)
4. move images to correct dir (select photographer for each image)
<!-- 5. enable external access to Hetzner storage box -->
6. check with `rsync --dry-run --delete -avP /home/chris/files/images/images apprun@nextcloud.chris-besch.com:/home/apprun/box/images/` in `/home/chris/files/images/images`
    or `rsync --delete -avP /home/chris/files/images/images apprun@nextcloud.chris-besch.com:/home/apprun/box/images/`
7. `rsync --delete -avP . u370909@u370909.your-storagebox.de:/home/images` in `/home/chris/files/images/images`
<!-- 8. disable external access to Hetzner storage box -->
9. rescan Photoprism library

# Screenshots Prodecure
1. `mogrify -format jpg *.png`
2. `rm *.png`
3. `exiftool '-EXIF:DateTimeOriginal<Filename' *`
4. `rm *.jpg_original`

# Other Useful Stuff
- `exiftool '-EXIF:DateTimeOriginal=2023-08-13-12-00' 001_{028..036}.jpg`

