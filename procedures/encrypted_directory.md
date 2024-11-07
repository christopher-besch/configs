# Create Image for Multiple Partitions
- `dd if=/dev/zero of=image.img iflag=fullblock bs=1M count=100 && sync` (set count to size in Mb)
- `sudo losetup -P loop0 image.img` (check next available loop device name with `losetup`)
- `sudo fdisk /dev/loop0`: create GPT partition table, create 'Linux filesystem' partition
- `sudo cryptsetup luksFormat /dev/loop0p1`
- `sudo cryptsetup open /dev/loop0p1 encrypted_img`
- `sudo mkfs.ext4 /dev/mapper/encrypted_img`
- `sudo cryptsetup close encrypted_img`
- `sudo losetup -d /dev/loop0`

# Create Image for Single Partition
- `dd if=/dev/zero of=image.img iflag=fullblock bs=1M count=100 && sync` (set count to size in Mb)
- `cryptsetup luksFormat image.img`
- `sudo cryptsetup open image.img encrypted_img`
- `sudo mkfs.ext4 /dev/mapper/encrypted_img`
- `sudo mount /dev/mapper/encrypted_img ~/mount` (use some mountpoint you like)
- `sudo chown -R chris ~/mount` (use your username)
- `sudo umount ~/mount`
- `sudo cryptsetup close encrypted_img`

# Open Image for Single Partition
- `sudo cryptsetup open image.img encrypted_img`
- `sudo mount /dev/mapper/encrypted_img ~/mount` (use some mountpoint you like)

# Close Image for Single Partition
- `sudo umount ~/mount`
- `sudo cryptsetup close encrypted_img`

# Resize Image
- `truncate -s 40G image.img`
- `sudo cryptsetup open image.img encrypted_img`
- `sudo cryptsetup resize encrypted_img`
- `sudo e2fsck -f /dev/mapper/encrypted_img`
- `sudo resize2fs /dev/mapper/encrypted_img`

# Sources
- https://askubuntu.com/questions/667291/create-blank-disk-image-for-file-storage
- https://unix.stackexchange.com/questions/751318/how-to-increase-the-size-of-a-luks-file-container
