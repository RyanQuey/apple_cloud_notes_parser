#!/bin/bash


#IMAGE_NAME="apple_cloud_notes_parser"
IMAGE_NAME="ghcr.io/threeplanetssoftware/apple_cloud_notes_parser"
CONTAINER_NAME="apple_cloud_notes_parser"

DATE=$(date '+%Y-%m-%d')
OUTPUT_DIR=~/notes/Dropbox/backups/iCloud-Notes.backups/$DATE

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
TMP_DIR=$PROJECT_DIR/tmp

LAST_BACKUP_PATH=$(cat $TMP_DIR/last_backup_path)
cat $TMP_DIR/last_backup_path
echo $LAST_BACKUP_PATH
open $LAST_BACKUP_PATH/notes_rip/html/all_notes_1.html
