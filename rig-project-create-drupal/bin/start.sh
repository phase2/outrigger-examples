#!/usr/bin/env bash
##
# Start
#
# This script takes your freshly cloned repository and takes it to a working
# Drupal site hosted in a Docker container stack.
##

CALLPATH=`dirname $0`
source "$CALLPATH/framework.sh"

echoWarn "Outrigger Drupal v4 dropped support for the start.sh script utility.\n"
echoWarn "For local development, replace your daily operations with rig project commands.\n"
echoError "Jenkins jobs should re-generated or refactored to use the individual steps.\n"
