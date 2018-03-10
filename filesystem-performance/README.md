# Test the Performance of Your Docker Filesystem

This helps sanity check the performance of your docker setup.

## Basic/NFS-based Filesystem Test

Run the following command and review the timing information output.

```
docker-compose run --rm perftest
```

## Outrigger Filesystem Sync Test

Run the following commands and review the timing information output.

```
rig project sync --dir=.
docker-compose run --rm filesync-perftest
```

## Local Filesystem Test

```
./perf-test.sh
```
