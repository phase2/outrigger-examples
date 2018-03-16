#!/usr/bin/env bash
##
# Post-Install
#
# Take actions after the installation process.
#
# This script is automatically triggered by Grunt after performing the actions
# of `grunt install`.
##

CALLPATH=$(dirname $0)
if [ -z $CALLPATH ]; then
  CALLPATH=.
fi
# Drupal 8 sets the permissions of the default directory such that it is not
# writable causing subsequent installations to fail. Also, when doing an
# install through the build container any files created have incorrect
# ownership for the web container to write to and modify them.
${CALLPATH}/fix-perms.sh

exit 0