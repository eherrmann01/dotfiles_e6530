#! /bin/bash
# Weekly /home backup
rsync -r -t -p -v --exclude '.local/share/Trash*'  --progress -s /home/erik/ /mnt/storage/linuxBackups/home/erik/ >> ~erik/Documents/rsync.log 2>&1
