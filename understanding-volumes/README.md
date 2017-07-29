# Understanding Docker Volumes and Outrigger

This folder contains configuration files for use in the steps below which
are meant to help you understand the various data storage locations available
with Outrigger. The exercises are meant to be completed in order and as you will
modify files as part of the process please be sure to complete the cleanup steps
and perform a `git checkout HEAD .` command and `git clean -fdX .` if you are
starting over so that all of the files are in their correct state.

## Familiarize Yourself With The Files

Key to these exercises will be a set of image files and directories that you will
change to see how the file index.html changes as they are modified. The
sample-image.png file in the root of the repo has a purple border and the
alternate-image.png file has a red border.

![sample-image.png file](sample-image.png)

![alternate-image.png file](alternate-image.png)

The sample-image.png file in the files-in-data directory has a blue border.

![files-in-data directory sample-image.png file](files-in-data/sample-image.png)  

Open the file [index.html](index.html) in a web browser. You should see 1 broken
image.

## Familiarize Yourself With The Volume Section Of docker-compose.yml

You will see there are three volume mappings declared. The current directory is
mapped to /var/www/html and will be accessed via NFS. The directory from the
docker machine /data/uv/files is mapped to /var/www/html/files-in-data and the
contents of the docker volume uv-sync is mapped to /var/www/html/files-via-unison.

Note that these exact same mappings will be used in build.yml.

## Start The Containers

Run the following commands to start the needed containers.

* `rig project sync:start` - this will create a docker volume named uv-sync and
start a unison process locally and a unison docker container to transfer files
between your local machine and your docker machine. All of the contents of the
current directory will be copied to the volume uv-sync.
* `docker-compose up` - this will start a web server container for you to access
at [http://www.uv.vm/](http://www.uv.vm/).
