#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 13:14:50 2022
#   For: 
#   Description: 

#Colors
NO='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
P='\033[0;35m'
C='\033[0;36m'

#Globals used
NAME=""
FILE=""
HEADERFILE=""
ARG=""
HEADER=""
EXTENSTION=""
HEADEREXTENSTION=""
DATE=$(date +"%A %b %d %Y at %r")
COPIESPATH="/Users/rionduckworth/codeProjects/bash/fileMaker/src/copies"
COPYFILE=""
COPYHEADER=""
PATHTOCOPY=""
PATHTOHEADERCOPY=""

function main() {
  if [[ $# -gt 2 ]] || [[ $# -eq 0 ]];
  then
    usage $R
  fi
  checkArgs $@
  buildFile
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
        shift 
        ;;
      -ch|--ch)
        ARGS+=("$1")
        EXTENSTION="c"
        HEADEREXTENSTION="h"
        COPYFILE="co.txt"
        COPYHEADER="ch.txt"
        shift 
        ;;
      -C|--cpp)
        ARGS+=("$1")
        EXTENSTION="cpp"
        COPYFILE="cpp.txt"
        shift
        ;;
      -Ch|--cpph)
        ARGS+=("$1")
        EXTENSTION="cpp"
        HEADEREXTENSTION="hpp"
        COPYFILE="cppo.txt"
        COPYHEADER="cpph.txt"
        shift
        ;;
      -j|--java)
        ARGS+=("$1")
        EXTENSTION="java"
        COPYFILE="java.txt"
        shift
        ;;
      -p|--python)
        ARGS+=("$1")
        EXTENSTION="py"
        COPYFILE="python.txt"
        shift
        ;;
      -m|--makeFile)
        ARGS+=("$1")
        COPYFILE="make.txt"
        shift
        ;;
      -b|--bash)
        ARGS+=("$1")
        EXTENSTION="sh"
        COPYFILE="bash.txt"
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

function buildFile() {
  FILE="$NAME.$EXTENSTION"
  checkForFile $FILE
  PATHTOCOPY="$COPIESPATH/$COPYFILE"
  PATHTOHEADERCOPY="$COPIESPATH/$COPYHEADER"
  case $ARG in
    -c|--c)
      buildCFile
      ;;
    -ch|--ch)
      buildCHFiles
      ;;
    -C|--cpp)
      buildCppFile
      ;;
    -Ch|--cpph)
      buildCpphFile
      ;;
    -j|--java)
      buildJavaFile
      ;;
    -p|--python)
      buildPythonFile
      ;;
    -m|--makeFile)
      buildMakeFile
      ;;
    -b|--bash)
      buildBashFile
      ;;
  esac 
}

function buildCFile() {
  echoC $O "Creating C file: $FILE"
  buildHeader '2' $FILE
  buildStartFile $FILE $COPYFILE
  echoC $G "Created C file: $FILE"
}

function buildCHFiles() {
  HEADERFILE="$NAME.$HEADEREXTENSTION"
  checkForFile $HEADERFILE
  echoC $O "Creating C header file: $HEADERFILE"
  buildHeader '3' $HEADERFILE
  buildStartFile $HEADERFILE $PATHTOHEADERCOPY
  echoC $O "Creating C file: $FILE"
  HEADER=""
  buildHeader '2' $FILE
  HEADER="${HEADER}#include \"$HEADERFILE\""
  buildStartFile $FILE $PATHTOCOPY
  echoC $G "Created C .c and .h files for: $NAME"
}

function buildCppFile() {
  echoC $O "Creating C++ file: $FILE"
  buildHeader '2' $FILE
  buildStartFile $FILE $COPYFILE
  echoC $G "Created C++ file: $FILE"
}

function buildCpphFile() {
  echo "not done"
}

function buildPythonFile() {
  echo "not done"
}

function buildJavaFile() {
  echo "not done"
}

function buildMakeFile() {
  echo "not done"
}

function buildHeader() {
  local comment=""
  if [[ $1 -eq "1" ]]; 
  then
    comment='#'
  else
    HEADER="${HEADER}/*\n"
    comment=" *"
  fi
  HEADER="${HEADER}${comment}   File: $2\n"
  HEADER="${HEADER}${comment}   Creator: Ernest M Duckworth IV\n"
  HEADER="${HEADER}${comment}   Created: $DATE\n"
  HEADER="${HEADER}${comment}   For: \n"
  HEADER="${HEADER}${comment}   Description: \n"
  if [ $1 -ne "1" ];
  then
    HEADER="${HEADER}*/\n"
  fi
  if [[ $1 -eq '3' ]];
  then
    local name=$(printf '%s\n' "$NAME" | awk '{ print toupper($0) }')
    local ext=$(printf '%s\n' "$EXTENSTION" | awk '{ print toupper($0) }')
    HEADER="${HEADER}#ifndef ${name}_${ext}\n"
    HEADER="${HEADER}#define ${name}_${ext}\n"
  fi
}

function buildStartFile() {
  touch $1
  echo -e "$HEADER" > $1
  cat "$2" >> $1
}

function checkForFile() {
  if [ -f "$1" ]; 
  then
    echoErr "$1 exists"
    exit 1
  fi
}

function echoC() {
   echo -e "${1}$2${NO}"
}

function echoErr() {
   echo -e "${R}$1${NO}" >&2
}

main $@
