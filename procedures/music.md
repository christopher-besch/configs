# Music Procedure
1. download music zip
2. extract into `[artist]/[album]`
3. convert covers to `cover.png`
4. `source ~/.custom_configs/music_scripts.sh`
5. check artist, album, title and track with `test_marwin .`
6. adjust with `eyeD3 --artist '[artist]' --album '[album]' *.mp3`
7. prettify title song by song (maybe use vi to batch edit titles)
8. `clean_music .`
9. create backup
10. `name_correct .`
11. fix errors manually
12. check all with `tree`
13. copy files into `/home/chris/files/music`
14. enable external access to Hetzner storage box
15. `rsync --dry-run --delete -avP /home/chris/files/music/ u370909@u370909.your-storagebox.de:/home/nextcloud_lfs/selchris_music` in `/home/chris/files/music` (remove `--dry-run`)
16. disable external access to Hetzner storage box
17. `docker exec -ti --user www-data NCFrontend /var/www/html/occ files:scan --all` on Hetzner server
18. rescan Music library
19. enjoy

