#!/usr/bin/env bash
##
# Update Scanner
#
# Uses drush pm-updatestatus to identify those modules that are outdated
# due to regular updates or important security releases. This produces
# clean output that focuses on action items and will cleanly fail so
# Jenkins jobs can report that module health is in an error state.
##

DATA=`drush @projectname pm-updatestatus 2> /dev/null`
echo "$DATA"
DATA=`echo "$DATA" | grep "available"`
# remove leading whitespace characters
DATA="${DATA#"${DATA%%[![:space:]]*}"}"
# remove trailing whitespace characters
DATA="${DATA%"${DATA##*[![:space:]]}"}"
if [ "$DATA" ];	then
  echo "==================================="
  echo $(echo "$DATA" | wc -l) packages need updating!
  exit 1
fi
exit 0
