# Example Jenkins Integration

This Jenkins setup can be added to any existing project to have self contained
Jenkins support in our Outrigger Integration environment. The goal is to have
a project-specific Jenkins container that can run Docker (and other) commands 
to provision environments, run tests, do code analysis, etc.

## Setup

The local jobs are stored in `env/jobs`.  The `env/plugins.txt` file contains 
pairs of `plugin-name:version` and those get processed and installed during 
the build phase.  This also mounts in the Docker binaries and socket so that 
Docker commands run inside this container can create containers on the Docker Host.

To run this container:

  - `docker-compose -f jenkins.yml build jenkins`
  - `docker-compose -f jenkins.yml run jenkins`

