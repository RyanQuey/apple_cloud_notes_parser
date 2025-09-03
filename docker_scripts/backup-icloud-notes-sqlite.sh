#!/bin/bash 

DATE=$(date '+%Y-%m-%d')
BACKUP_DIR=~/notes/Dropbox/backups/iCloud-Notes.backups/$DATE

mkdir -p $BACKUP_DIR
echo "making backup at $BACKUP_DIR"

cp ~/Library/Group\ Containers/group.com.apple.notes/NoteStore.{sqlite,sqlite-shm,sqlite-wal} $BACKUP_DIR
echo "done"
