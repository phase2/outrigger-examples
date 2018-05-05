#!/usr/bin/env bash
##
# Seed Users
#
# Creates dummy users for testing.
#
# Run from root of the code repository.
#
# This script is not automatically triggered by Grunt, and must be run/automated
# separately if desired in a given environment.
##

drush @projectname user-create "projectnameadmin" --password="admin1" --mail="projectnameadmin@example.com"
drush @projectname user-add-role "administrator" "projectnameadmin"
