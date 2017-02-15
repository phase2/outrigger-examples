# Introduction

This example shows how to use pattern lab using only tooling installed
in the build containers.

This assumes that the pattern-lab-starter directory is a sibling to the
current directory. If you want to adjust this, change the volume mapping
in base.yml.

## Usage

* Clone [pattern-lab-starter](https://github.com/phase2/pattern-lab-starter)
as a sibling to this directory. Example `git clone git@github.com:phase2/pattern-lab-starter.git ../pattern-lab-starter`
* Prepare pattern lab: `docker-compose -f build.yml run --rm install`
* Starting server and file processing: `docker-compose up`. You can view
the pattern lab instance at [http://patternlab.outrigger.vm:3050](http://patternlab.outrigger.vm:3050)
once file processing has completed and the server has started. Watch
the output of the container to see the start message though note that
the URLs do not all report correctly in that message.
* Speed up change propagation to container by running `rig watch ../pattern-lab-starter/source`
* If you want to use tools interactively, you can use the cli container
by running `docker-compose -f build.yml run --rm cli`

## File Descriptions

### build.yml

Contains base setup for other files to inherit services from as well as
service definitions for the command line service and install service.

### docker-compose.yml

Defines a server instance that hosts the pattern lab files and watches
for file changes that need processing.

### .rig-watch-ignore

Exclude patterns for `rig watch` command. Example exclusions are
for Vim and PhpStorm and are intended to catch the following:
* Files which have \_\_\_jb\_tmp\_\_\_ or \_\_\_jb\_old\_\_\_ appended
which are PhpStorm temporary files.
* Files which have a ~ or .sw\[ANYTHING\] at the end which are Vim swap
and backup files.
