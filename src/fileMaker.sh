#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 13:14:50 2022
#   For: fileMaker
#   Description: Creates a handful of differnt "Hello World!" programs for various langauges
#   Notes:
#         - SET-UP
#            - set USER MODIFY VARIABLES
#            - OPTIONAL: set alias in .bashrc/.bash_profile/.bash_aliases/etc
#            - run program with correct args and create files
#         - ADDITION
#            - Add base file to /src/copies
#            - add configurment to checkArgs() function 

#######################################################################
#MODIFY PATH BELOW TO LOCAL CONFIG FILE
CONFIG="/Users/rionduckworth/codeProjects/bash/fileMaker/src/config.sh"
#######################################################################

#Color for Output 
NO='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
P='\033[0;35m'
B='\033[0;36m'

#PROGRAM GLOBALS
NAME=""
FILE=""
HEADERFILE=""
ARG=""
HEADER=""
EXTENSTION=""
HEADEREXTENSTION=""
COPYFILE=""
COPYHEADER=""
PATHTOCOPY=""
PATHTOHEADERCOPY=""
LANGUAGE=""
COMMENT=""

function main() {
  if [[ $# -gt 2 ]] || [[ $# -eq 0 ]];
  then
    usage $R
  fi
  checkArgs $@
  startBuildForFile
}

function usage() {
  echoErr "${1}[USAGE]: PROMPT$ fileMaker.sh -OPTION FILE_NAME"
  echoErr "${1}OPTIONS:"
  echoErr "  ${1}-j  | --java"
  echoErr "  ${1}-p  | --python"
  echoErr "  ${1}-c  | --C"
  echoErr "  ${1}-ch | --Ch"
  echoErr "  ${1}-C  | --cpp"
  echoErr "  ${1}-Ch | --cpph"
  echoErr "  ${1}-m  | --makefile"
  echoErr "  ${1}-b  | --bash"
  exit 1
}

function checkArgs() {
  local POSITIONAL_ARGS=()
  local ARGS=()
  while [[ $# -gt 0 ]]; do
    case $1 in
      -c|--c)
        ARGS+=("$1")
        EXTENSTION="c"
        COPYFILE="c.txt"
        LANGUAGE="C"
        COMMENT=" *"
        shift 
        ;;
      -ch|--ch)
        ARGS+=("$1")
        EXTENSTION="c"
        HEADEREXTENSTION="h"
        COPYFILE="co.txt"
        COPYHEADER="ch.txt"
        LANGUAGE="C"
        COMMENT=" *"
        shift 
        ;;
      -C|--cpp)
        ARGS+=("$1")
        EXTENSTION="cpp"
        COPYFILE="cpp.txt"
        LANGUAGE="C++"
        COMMENT=" *"
        shift
        ;;
      -Ch|--cpph)
        ARGS+=("$1")
        EXTENSTION="cpp"
        HEADEREXTENSTION="hpp"
        COPYFILE="cppo.txt"
        COPYHEADER="cpph.txt"
        LANGUAGE="C++"
        COMMENT=" *"
        shift
        ;;
      -j|--java)
        ARGS+=("$1")
        EXTENSTION="java"
        COPYFILE="java.txt"
        LANGUAGE="java"
        COMMENT=" *"
        shift
        ;;
      -p|--python)
        ARGS+=("$1")
        EXTENSTION="py"
        COPYFILE="python.txt"
        LANGUAGE="python"
        COMMENT="#"
        shift
        ;;
      -m|--makeFile)
        ARGS+=("$1")
        COPYFILE="make.txt"
        LANGUAGE="make"
        COMMENT="#"
        shift
        ;;
      -b|--bash)
        ARGS+=("$1")
        EXTENSTION="sh"
        COPYFILE="bash.txt"
        LANGUAGE="bash"
        COMMENT="#"
        shift
        ;;
      -h|--help)
        usage $O
        ;;
      -*|--*)
        usage $R
        ;;
      *)
        POSITIONAL_ARGS+=("$1") 
        shift 
        ;;
    esac
  done
  if [[ ${#ARGS[@]} -ne 1 ]] || [[ ${#POSITIONAL_ARGS[@]} -gt 1 ]];
  then 
      usage $R
  fi
  ARG="${ARGS[0]}"
  if [[ ${#POSITIONAL_ARGS[@]} -eq 0 ]];
  then
    NAME="main"
  else
    NAME="${POSITIONAL_ARGS[0]}" 
  fi
}

function startBuildForFile() {
  if [[ "$LANGUAGE" == "make" ]];
  then
    FILE="Makefile"
  else 
    FILE="$NAME.$EXTENSTION"
  fi
  checkForFile $FILE
  PATHTOCOPY="$COPIESPATH/$COPYFILE"
  PATHTOHEADERCOPY="$COPIESPATH/$COPYHEADER"
  if [[ "$HEADEREXTENSTION" != "" ]];
  then
    buildHeaderFile
  else
    buildBodyFile
  fi
}

function buildBodyFile() {
  if [[ "$LANGUAGE" == "make" ]];
  then
    FILE="Makefile"
  fi
  buildHeader $FILE
  if [[ "$HEADERFILE" != '' ]];
  then
    HEADER="${HEADER}\n#include \"$HEADERFILE\""
  elif [[ "$LANGUAGE" == 'java' ]];
  then
    HEADER="${HEADER}\nclass $NAME{"
  fi
  buildFile $FILE $PATHTOCOPY
  echoC $G "Created ${B}$LANGUAGE${G} file: ${P}$FILE"
}

function buildHeaderFile() {
  HEADERFILE="$NAME.$HEADEREXTENSTION"
  checkForFile $HEADERFILE
  buildHeader $HEADERFILE
  local name=$(printf '%s\n' "$NAME" | awk '{ print toupper($0) }')
  local ext=$(printf '%s\n' "$EXTENSTION" | awk '{ print toupper($0) }')
  HEADER="${HEADER}\n#ifndef ${name}_${ext}\n"
  HEADER="${HEADER}#define ${name}_${ext}"
  buildFile $HEADERFILE $PATHTOHEADERCOPY
  echoC $G "Created ${B}$LANGUAGE${G} file: ${P}$HEADERFILE"
  HEADER=""
  buildBodyFile
  echoC $G "Created ${B}$LANGUAGE${G} files for: ${P}$NAME"
}

function buildHeader() {
  if [[ "$COMMENT" == " *" ]];
  then
    HEADER="${HEADER}/*\n"
  fi
  HEADER="${HEADER}${COMMENT}   File: $1\n"
  HEADER="${HEADER}${COMMENT}   Creator: $CREATOR\n"
  HEADER="${HEADER}${COMMENT}   Created: $DATE\n"
  HEADER="${HEADER}${COMMENT}   For: \n"
  HEADER="${HEADER}${COMMENT}   Description:"
  if [[ "$COMMENT" == " *" ]];
  then
    HEADER="${HEADER}\n*/"
  fi
}

function buildFile() {
  touch "$1"
  echo -e "$HEADER" > "$1"
  cat "$2" >> "$1"
}

function checkForFile() {
  if [ -f "$1" ]; 
  then
    echoErr "${P}$1${R} already exists"
    exit 1
  fi
}

function echoC() {
   echo -e "${1}$2${NO}"
}

function echoErr() {
   echo -e "${R}$1${NO}" >&2
}

if [[ -f $CONFIG ]];
then
  source $CONFIG
  if [[ ! -d $COPIESPATH ]];
  then
    echoErr "Cannot find ${P} copies folder"
    echoErr "Current copies path: ${P}$COPIESPATH"
  fi
else
  echoErr "Cannot find ${P}config.sh"
  echoErr "Current config path: ${P}$CONFIG"
  exit 1
fi



main $@
