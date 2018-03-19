# Test the Performance of Your Docker Filesystem

This helps sanity check the performance of your docker setup.

## Basic/NFS-based Filesystem Test

Run the following command and review the timing information output.

```
docker-compose run --rm perftest
```

## Outrigger Filesystem Sync Tests

Run the following commands and review the timing information output. This will exercise the filesystem in your docker volume and the synchronization process to your local filesystem.

```
rig project sync --dir=.
docker-compose run --rm filesync-perftest
```

### Local Filesystem Test 1

Running this will exercise your local filesystem and the synchronization process to the volume in your docker host.

```
./perf-test.sh
```

### Local Filesystem Test 2

This test will severely stress the filesystem operations locally while monitoring to see if the local unison process appears to still be functioning. If it runs all the way to completion sucessfully you can try tweaking some of the file sizes and file count loops at the top of the file. 

```
./sync-test.sh
```
