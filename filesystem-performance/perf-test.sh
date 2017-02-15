#!/bin/bash

I=0
SIZE_MULTIPLE=1
BLOCK_SIZE=1
BLOCK_COUNT=$(expr 10 \* 1024)
mkdir -p perf-test
dd if=/dev/urandom of=perf-test/$I.bin bs=$BLOCK_SIZE count=$BLOCK_COUNT
PREV_I=$I
I=$(expr $I + 1)
while [ $I -lt 20 ]; do
  dd if=perf-test/$PREV_I.bin of=perf-test/$I.bin bs=$BLOCK_SIZE count=$BLOCK_COUNT
  PREV_I=$I
  I=$(expr $I + 1)
done

rm -rf perf-test

echo ================================================================
echo Your timing is output below, if the time required for this test
echo is greater than 60 seconds then you should seek help with your
echo system setup. Good performance is typically in the 40 second
echo range. You can also compare to native performance by running the
echo perf-test.sh script from your host and comparing timing to when
echo it runs from a container.
echo ================================================================

