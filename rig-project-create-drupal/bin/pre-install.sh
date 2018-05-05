#!/usr/bin/env bash
##
# Pre-Install
#
# Take actions in between the build process and installation.
#
# Run from root of the code repository.
#
# This script is automatically triggered by Grunt before performing the actions
# of `grunt install`.
##

if [ ! -f src/sites/default/default.settings.php ]; then
  echo "Please run pre-install after successfully building the docroot."
  exit 1
fi

# Ensure Redis does not hold onto stale data in between site installation runs.
echo "Flush Redis cache with 'FLUSHALL'"
(echo -en "FLUSHALL\r\n"; sleep 1) | nc cache 6379

if [ ! -f src/sites/default/settings.php ]; then
  cp src/sites/default/default.settings.php src/sites/default/settings.php
  echo -e "\nrequire __DIR__ . '/../settings.common.php';" >> src/sites/default/settings.php
else
  echo "'src/sites/default/settings.php' already exists."
fi

exit 0
