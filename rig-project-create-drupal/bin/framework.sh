#!/usr/bin/env bash
##
# Framework.Shell
#
# Library of BASH helper functions.
##

# Wrap commands for eval to conditionally output rather than execute.
# Requires an exported $NOOP variable.
cmd() {
  echoInfo "$1\n"
  if [ $NOOP != 1 ]; then
    eval $1
  fi
}

##
# Fancy output from earlier version of devtools.
# https://bitbucket.org/phase2tech/_devtools_vm
#
# This is a collection of variables and functions to make printing
# attractive output in our shell scripts easier for everyone.
#
# Sample usage:
#
# 1) To print an info message with success confirmation
#    example:  [INFO] Checking something ...    OK
#
#      echoInfo "Checking something ... \t"
#      [add your somthing commands here]
#      echoSuccess "OK\n"
#
# 2) To print an info message with failure confirmation
#    example:  [INFO] Checking something ...    FAIL
#                 Something is screwed up
#
#      echoInfo "Checking something ... \t"
#      [add your somthing commands here]
#      echoFail "Something is screwed up\n"
#
# 3) To print a warning:
#    example:  [WARN] Something is not just right!
#
#      echoWarn "Something is just not right! \n"
#
# 4) To have a sub script print out with a bit of style/color (it will be cyan)
#
#      outputColor
#      [call your scripts]
#      resetColor
#
# 5) To print the properties of something
#    example:
#             [INFO] Configuration:
#
#               - Machine Name: dev
#               - Shared Folder: /Users
#
#
#       echoInfo "Configuration: "
#       echo
#       echo
#       echoProperties "Machine Name: $name"
#       echoProperties "Shared Folder: $folder"
##

Reset='\e[0m';
Red='\e[0;31m';
Green='\e[0;32m';
Yellow='\e[0;33m';
Blue='\e[1;34m';
Purple='\e[0;35m';
Cyan='\e[0;36m';

Bold='\033[1m';
Normal='\033[0m';
Underline='\033[4m';

# @info:    Prints error messages
# @args:    error-message
echoError () {
  printf "${Red}[ERROR] ${Reset}$1"
}

# @info:    Prints error messages
# @args:    error-message
echoFail () {
  printf "${Red}FAIL\n\n$1 ${Reset}"
}

# @info:    Prints warning messages
# @args:    warning-message
echoWarn () {
  printf "${Yellow}[WARN] ${Reset}$1"
}

# @info:    Prints success messages
# @args:    success-message
echoSuccess () {
  printf "${Green}$1${Reset}"
}

# @info:    Prints check messages
# @args:    success-message
echoInfo () {
  printf "${Blue}[INFO] ${Reset}$1"
}

# @info:    Prints property messages
# @args:    property-message
echoProperties () {
  printf "\t${Purple}- $1 \033[0m"
}

# @info:    Change color for subscript output
function outputColor {
  printf "${Cyan}"
}

# @info:    Reset terminal color
function resetColor  {
  printf "${Reset}"
}

# @info:    Bold text
function outputBold {
  printf "${Bold}"
}

# @info:    Normal text weight
function resetText {
  printf "${Normal}"
}

# @info:    Output text with underline
function outputUnderline {
  printf "${Underline}"
}

# @info:    Set a heading
function heading {
  outputColor
  outputBold
  outputUnderline
  echo -e "${Bold}$1${Normal}"
  resetText
}
