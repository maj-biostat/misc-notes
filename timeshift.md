# Timeshift - backups

Timeshift is a backup utility.

For external drives, they need to be of type ext4.

Do identify the path to the external drive, plug it in and do `df  -h`.
Say /dev/sdb1 is the path to the external drive, use

```
sudo umount -lf /dev/sdb1 
mkfs.ext4 /dev/sdb1
```

