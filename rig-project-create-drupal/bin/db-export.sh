#!/usr/bin/env bash
##
# Database Export
#
# Sanitize and prepare the database for clean import in other environments.
#
# This script is intended to facilitate Jenkins jobs that export the database,
# especially for backups or local development. Jenkins usage might look like:
#
# > docker-compose -f build.yml run cli bash bin/db-export.sh nightlies/20151027.sql
#
# Arguments
# - Relative path to database export file inside the /opt/backups directory.
##

# Prepare the destination.
FILE="/opt/backups/$1"
DIR=$(dirname "$FILE")
mkdir -pv "$DIR"

# Scramble private data.
drush @projectname sql-sanitize -yv
# Ensure first cache clear after db import does not conflict with features export changes.
drush @projectname variable-set features_rebuild_on_flush 0 -y --exact
# Export the file. See /etc/drushrc.php for additional configuration defaults.
drush @projectname sql-dump --gzip --ordered-dump --result-file="$FILE" -yv

# Maintain a symlink to the most recently generated database export for ease of download.
ln -fsv "./$1.gz" /opt/backups/latest.sql.gz

# Purge all but the most recent 5 database exports in this directory.
cd $DIR && ls -t | awk 'NR>5' | xargs rm -f
