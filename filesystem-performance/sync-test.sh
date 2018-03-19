#!/bin/bash

BASE_DIR=generated-files
BASE_FILE=$(mktemp)
DIR=0
DUPE=0
# make $FILE_LOOP number of files in each of $DIR_LOOPS directories
DIR_LOOPS=16
FILE_LOOPS=8192
DUPE_LOOPS=4
# Make the generated files of BLOCK_SIZE * BLOCK_COUNT byte size
BLOCK_SIZE=512
BLOCK_COUNT=16
# How long to sleep between some operations
SLEEP=1


check_process() {
  RESULTS=$(ps aux | grep unison | grep perftest-sync)
  if [ $? -ne 0 ]; then
    echo "Local unison process seems to have crashed"
    exit
  fi
}

clean_dupe_dirs() {
  echo "Delete the duplicated directories using rm"
  # clean out the directories
  rm -rf $BASE_DIR-*
  check_process
}

# Start off everything clean, shutting down and removing legacy volumes and containers if needed
rm -rf $BASE_DIR-*
rm -rf $BASE_DIR
OUTPUT=$(docker top perftest-sync)
if [ $? -eq 0 ]; then
  rig project sync:stop
fi
docker volume rm perftest-sync
rig project sync --dir=.

echo ""
dd if=/dev/urandom of=$BASE_FILE bs=$BLOCK_SIZE count=$BLOCK_COUNT 2>/dev/null

echo "Making $(expr $FILE_LOOPS \* $DIR_LOOPS) files of size $(expr $BLOCK_SIZE \* $BLOCK_COUNT) bytes across $DIR_LOOPS directories"
while [ $DIR -lt $DIR_LOOPS ]; do
  FILE=0
  mkdir -p $BASE_DIR/$DIR
  while [ $FILE -lt $FILE_LOOPS ]; do
    cp $BASE_FILE $BASE_DIR/$DIR/$FILE.bin
    FILE=$(expr $FILE + 1)
  done
  echo "Done generating directory $DIR"
  check_process
  DIR=$(expr $DIR + 1)
done

echo "Cloning created directories and files $DUPE_LOOPS times, mv them around some sleeping shortly between"
DUPE=0
while [ $DUPE -lt $DUPE_LOOPS ]; do
  cp -R $BASE_DIR $BASE_DIR-$DUPE
  sleep $SLEEP
  mv $BASE_DIR-$DUPE $BASE_DIR-$DUPE-$DUPE
  sleep $SLEEP
  mv $BASE_DIR-$DUPE-$DUPE $BASE_DIR-$DUPE
  DUPE=$(expr $DUPE + 1)
  echo "Copy and move $DUPE complete"
  check_process
done

if [ $FILE_LOOPS -lt 256 ]; then
  echo "Cleaning generated files in each numbered directory in cloned dupes using rm"
  DIR=0
  DUPE=0
  while [ $DUPE -lt $DUPE_LOOPS ]; do
    while [ $DIR -lt $DIR_LOOPS ]; do
      rm $BASE_DIR-$DUPE/$DIR/*
      DIR=$(expr $DIR + 1)
      sleep $SLEEP
    done
    DUPE=$(expr $DUPE + 1)
  done
  echo "Cleaned directory $DIR in dupe $DUPE"
  check_process
fi

clean_dupe_dirs

echo "Cloning created directories and files $DUPE_LOOPS times, sleep between clones"
DUPE=0
while [ $DUPE -lt $DUPE_LOOPS ]; do
  cp -R $BASE_DIR $BASE_DIR-$DUPE
  echo "Cloned dupe directory $DUPE"
  check_process
  DUPE=$(expr $DUPE + 1)
  sleep $SLEEP
done

echo "Cleaning generated files in each numbered directory in cloned dupes using find"
DIR=0
DUPE=0
while [ $DUPE -lt $DUPE_LOOPS ]; do
  find $BASE_DIR-$DUPE -type f -exec rm {} \;
  echo "Cleaned dupe directory $DUPE"
  check_process
  DUPE=$(expr $DUPE + 1)
done

clean_dupe_dirs

echo "Cloning created directories $DUPE_LOOPS times, no sleep"
DUPE=0
while [ $DUPE -lt $DUPE_LOOPS ]; do
  cp -R $BASE_DIR $BASE_DIR-$DUPE
  DUPE=$(expr $DUPE + 1)
  echo "Cloned dupe directory $DUPE"
  check_process
done

echo "Cleaning generated files by removing numbered directories in the clones, no sleep"
DIR=0
DUPE=0
while [ $DUPE -lt $DUPE_LOOPS ]; do
  while [ $DIR -lt $DIR_LOOPS ]; do
    rm -rf $BASE_DIR-$DUPE/$DIR
    DIR=$(expr $DIR + 1)
  done
  DUPE=$(expr $DUPE + 1)
done

clean_dupe_dirs
rm -rf $BASE_DIR
rm $BASE_FILE
