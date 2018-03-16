#!/usr/bin/env bash
##
# Features Health Scanner
#
# Lists features and checks them for errors states: overridden, needs review, or
# conflict. Any such feature is counted as "unhleathy". If any features are
# unhealthy the script will return an error.
##

DATA=`drush @projectname features-list --status=enabled`
echo "$DATA"
DATA=`echo "$DATA" | egrep -w "Overridden|Needs review|Conflicts"`
# remove leading whitespace characters
DATA="${DATA#"${DATA%%[![:space:]]*}"}"
# remove trailing whitespace characters
DATA="${DATA%"${DATA##*[![:space:]]}"}"
if [ "$DATA" ];	then
  echo "==================================="
  echo $(echo "$DATA" | wc -l) features need attention!
  exit 1
fi
exit 0
