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

## Note The Difference In Images That Display

The contents of index.html explain why the various images do not display.

## Understanding Unison Syncing

The first image became visible when viewing the file through the web server because
the contents of the current directory were copied to the volume uv-sync. That 
volume was mapped to path /var/www/html/files-via-unison. When unison is running
the first image will always match the second because they are the same file.
 
To see the effects of unison syncing do the following:

* Run `rig project sync:stop` to stop the syncing
* Run `cp alternate-image.png sample-image.png` to update the sample image file.
* Refresh your browser and not that the file displayed for the second image 
at [http://www.uv.vm/](http://www.uv.vm/) now does not match the first.
* Run `rig project sync:start`
* Refresh your browser and note that the files now match.

## Understanding Unison Syncing Part 2

Run the command `docker volume inspect uv-sync` and copy the value of the
Mountpoint.

Use it to run `docker-machine ssh dev sudo ls VALUE_OF_MOUNTPOINT`

This is where the files are being copied inside your docker machine. 

## Understanding the Data Directory

Outrigger sets up a persistent storage area inside your docker machine at the
path /data. Anything you map to that path is automatically persistent until you
delete it.

### Understanding Volume Mapping Masking

Volume mappings can mask directories which would normally be visible. This is
why the third image breaks when viewed at [http://www.uv.vm/](http://www.uv.vm/).
It's now being looked for from directory /data/uv/files.

Do the following to "unmask" the files-in-data directory.

* Run `docker-compose stop`
* Comment out the line `- /data/uv/files:/var/www/html/files-in-data` from
docker-compose.yml
* Run `docker-compose up`
* Refresh your browser and see that the third image now displays.

Restore the volume mapping by stopping your www container and uncommenting the
line you changed in docker-compose.yml and then restarting your container.

### Inspecting The Data Directory

Run `docker-machine ssh dev sudo ls /data/uv/files` to see the contents of the
mapped data directory which should be empty at this point.

### Copying Files to the /data Directory

Because we have the same mappings in the build container, we can use it to copy
files to the /data directory.

* Run `docker-compose -f build.yml run --rm cli`
* Run `cp sample-image.png files-in-data/`
* Refresh your browser and see that the second and third files now match.

## Clean Up Steps

Do the following to stop all containers and remove files from the /data directory.

* `docker-compose stop`
* `rig project sync:stop`
* `docker-machine ssh dev sudo rm -rf /data/uv`
