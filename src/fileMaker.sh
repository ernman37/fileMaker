#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 13:14:50 2022
#   For: 
#   Description: 

#Colors
N='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
BLUE='\033[0;34m'
P='\033[0;35m'
C='\033[0;36m'

#Globals needed
FILE=""
ARG=""

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
        shift 
        ;;
      -ch|--ch)
        ARGS+=("$1")
        shift 
        ;;
      -C|--cpp)
        ARGS+=("$1")
        shift
        ;;
      -Ch|--cpph)
        ARGS+=("$1")
        shift
        ;;
      -j|--java)
        ARGS+=("$1")
        shift
        ;;
      -p|--python)
        ARGS+=("$1")
        shift
        ;;
      -m|--makeFile)
        ARGS+=("$1")
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
  if [[ ${#POSITIONAL_ARGS[@]} -eq 0]];
  then
    FILE="main"
  else
    FILE="${POSITIONAL_ARGS[0]}" 
  fi
}

function buildFile() {
  case $arg in
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
  esac 
}

function buildCFile() {
  local fileName="$FILE.c"
  checkForFile $fileName

}

function buildCHFiles() {
  local fileName="$FILE.c"
  checkForFile $fileName
  local headerFileName="$FILE.h"
  checkForFile $headerFileName

}

function buildCppFile() {
  local fileName="$FILE.cpp"
  checkForFile $fileName

}

function buildCpphFile() {
  FILE="$FILE.cpp"
  checkForFile $fileName
  FILE="$FILE.hpp"
  checkForFile $headerFileName

}

function buildPythonFile() {
  FILE="$FILE.py"
  checkForFile $fileName

}

function buildJavaFile() {
  FILE="$FILE.java"
  checkForFile $fileName

}

function buildMakeFile() {
  local fileName="Makefile"
  checkForFile $fileName
}

function buildHeader() {

}


function checkForFile() {
  if [ -f "$1" ]; then
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
