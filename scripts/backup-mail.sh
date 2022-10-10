#! /bin/bash

mailfolder="/home/erik/.local/share/mail"
backupfolder="/usr/local/Private/backup/mail"
datelabel=$(date +%Y-%m-%d)

echo "backing up for $datelabel \n"
for i in ${mailfolder}/* ; do
  if [ -d "$i" ]; then
    dirname=$(basename "$i")
    echo $dirname
    mkdir -p $backupfolder/$dirname
    tar -cvf $backupfolder/$dirname/$dirname-$datelabel.tar.gz $i > /dev/null
    find $backupfolder/$dirname -type f -mtime +2 -exec rm {} \;
  fi
done
