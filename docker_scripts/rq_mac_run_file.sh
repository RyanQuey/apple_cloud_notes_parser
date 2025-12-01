#!/bin/bash


#IMAGE_NAME="apple_cloud_notes_parser"
IMAGE_NAME="ghcr.io/threeplanetssoftware/apple_cloud_notes_parser"
CONTAINER_NAME="apple_cloud_notes_parser"

DATE=$(date '+%Y-%m-%d')
OUTPUT_DIR=~/notes/Dropbox/backups/iCloud-Notes.backups/$DATE
LATEST_DIR=~/notes/Dropbox/backups/iCloud-Notes.backups/latest

COMMAND="-f /data/NoteStore.sqlite"
COMMAND="$COMMAND --one-output-folder"
# not necessary, hte docker volume will do this already
#COMMAND="$COMMAND --output-dir $OUTPUT_DIR"

echo "Using Docker to run ruby notes_cloud_parser.rb $COMMAND"

# docker run --rm --name \
#   $CONTAINER_NAME \
#   --volume "$(pwd):/data:ro" \
#   --volume "$(pwd)/output:/app/output" \
#   $IMAGE_NAME \
#   $COMMAND


SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PROJECT_DIR=$SCRIPT_DIR/..
TMP_DIR=$PROJECT_DIR/tmp

mkdir -p $TMP_DIR

# move sqlite file into working dir
cp ~/Library/Group\ Containers/group.com.apple.notes/NoteStore.{sqlite,sqlite-shm,sqlite-wal} $TMP_DIR

# go to project dir, so that 
cd $TMP_DIR

# creates output dir, and puts the html there
docker run --rm --name \
  $CONTAINER_NAME \
  --volume "$TMP_DIR:/data" \
  --volume "$OUTPUT_DIR:/app/output" \
  $IMAGE_NAME \
  $COMMAND


# copying to `latest` dir, so I can have a nice git blame file too for all of these
# - merging, so old files are kept alone, but new files are added. https://stackoverflow.com/a/20142456/6952495
# - but I can just do -R, without T, since I want to overwrite old files
mkdir -p $LATEST_DIR
cp -R $OUTPUT_DIR $LATEST_DIR

# make it easy to open the html file
# - Note that the below overwrites
echo $OUTPUT_DIR > $TMP_DIR/last_backup_path
echo "run below command to see the html files:"
echo "$SCRIPT_DIR/open_last_html.sh"
