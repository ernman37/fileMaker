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
DEFAULTNAME="main"
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
PRESPACE=""
SPACING="    "
TOPCOMMENT=""
BOTTOMCOMMENT=""
TEST=0
GOT_COMMENTS="0"
FOR_COMMENT=""
DESCRIPTION_COMMENT=""

function main() {
  if [[ $# -gt 2 ]] || [[ $# -eq 0 ]];
  then
    usage $R
  fi
  if [[ "$GOT_COMMENTS" == "0" ]];
  then
    GOT_COMMENTS="1"
    read -p "For: " FOR_COMMENT
    read -p "Description: " DESCRIPTION_COMMENT
  fi
  setUp
  checkArgs $@
  startBuildForFile
}

function setUp(){
  DEFAULTNAME="main"
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
  PRESPACE=""
  SPACING="    "
  TOPCOMMENT=""
  BOTTOMCOMMENT=""
  TEST=0
}

function usage() {
  echoErr "${1}[USAGE]: PROMPT$ fileMaker.sh -OPTION FILE_NAME"
  echoErr "${1}OPTIONS:"
  echoErr "  ${1}-j   | --java"
  echoErr "  ${1}-p   | --python"
  echoErr "  ${1}-c   | --C"
  echoErr "  ${1}-ch  | --Ch"
  echoErr "  ${1}-C   | --cpp"
  echoErr "  ${1}-Ch  | --cpph"
  echoErr "  ${1}-m   | --makefile"
  echoErr "  ${1}-b   | --bash"
  echoErr "  ${1}-H   | --html"
  echoErr "  ${1}-s   | --css"
  echoErr "  ${1}-P   | --php"
  echoErr "  ${1}-js  | --javascript"
  echoErr "  ${1}-jst | --javascriptTest"
  echoErr "  ${1}-t   | --typescript"
  echoErr "  ${1}-tt  | --typescriptTest"
  echoErr "  ${1}-r   | --ruby"
  echoErr "  ${1}-M   | --markdown"
  echoErr "  ${1}-n   | --note (.txt)"
  echoErr "  ${1}-d   | --dir (project dir)"
  echoErr "  ${1}-h   | --help" 
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
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
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
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift 
        ;;
      -C|--cpp)
        ARGS+=("$1")
        EXTENSTION="cpp"
        COPYFILE="cpp.txt"
        LANGUAGE="C++"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
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
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift
        ;;
      -j|--java)
        ARGS+=("$1")
        EXTENSTION="java"
        COPYFILE="java.txt"
        LANGUAGE="java"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift
        ;;
      -p|--python)
        ARGS+=("$1")
        EXTENSTION="py"
        COPYFILE="python.txt"
        LANGUAGE="python"
        TOPCOMMENT="'''"
        BOTTOMCOMMENT="'''"
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
        HEADER="#!/bin/bash\n"
        SPACING="   "
        shift
        ;;
      -H|--html)
        ARGS+=("$1")
        EXTENSTION="html"
        COPYFILE="html.txt"
        LANGUAGE="html"
        TOPCOMMENT="<!--"
        BOTTOMCOMMENT="--->"
        shift
        ;;
      -s|--css)
        ARGS+=("$1")
        EXTENSTION="css"
        COPYFILE="css.txt"
        LANGUAGE="css"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift
        ;;
      -P|--php)
        ARGS+=("$1")
        EXTENSTION="php"
        COPYFILE="php.txt"
        LANGUAGE="php"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        HEADER="#!/bin/php\n<?php\n"
        PRESPACE="  "
        shift
        ;;
      -js|--javascript)
        ARGS+=("$1")
        EXTENSTION="js"
        COPYFILE="javascript.txt"
        LANGUAGE="javascript"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift
        ;;
      -jst|--javascriptTest)
        ARGS+=("$1")
        EXTENSTION="js"
        COPYFILE="javascript.test.txt"
        LANGUAGE="javascript"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        TEST=1
        shift
        ;;
      -t|--typescript)
        ARGS+=("$1")
        EXTENSTION="ts"
        COPYFILE="javascript.txt"
        LANGUAGE="typescript"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        shift
        ;;
      -Tt|--typescriptTest)
        ARGS+=("$1")
        EXTENSTION="ts"
        COPYFILE="javascript.test.txt"
        LANGUAGE="typescript"
        COMMENT=" *"
        TOPCOMMENT="/*"
        BOTTOMCOMMENT="*/"
        TEST=1
        shift
        ;;
      -r|--ruby)
        ARGS+=("$1")
        EXTENSTION="rb"
        COPYFILE="ruby.txt"
        LANGUAGE="ruby"
        COMMENT="#"
        shift
        ;;
      -M|--markdown)
        ARGS+=("$1")
        EXTENSTION="md"
        COPYFILE="markdown.txt"
        LANGUAGE="markdown"
        TOPCOMMENT="<!--"
        BOTTOMCOMMENT="--->"
        DEFAULTNAME="README"
        shift
        ;;
      -n|--note)
        ARGS+=("$1")
        EXTENSTION="txt"
        COPYFILE="note.txt"
        LANGUAGE="note"
        SPACING=""
        DEFAULTNAME="$(date +"%m-%d-%Y")"
        shift
        ;;
      -d|--dir)
        ARGS+=("$1")
        EXTENSTION=""
        COPYFILE=""
        LANGUAGE="directory"
        SPACING=""
        DEFAULTNAME="newProject"
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
    NAME=$DEFAULTNAME
  else
    NAME="${POSITIONAL_ARGS[0]}" 
  fi
}

function startBuildForFile() {
  if [[ "$LANGUAGE" == "make" ]];
  then
    FILE="Makefile"
  elif [[ $TEST -eq 1 ]];
  then 
    FILE="$NAME.test.$EXTENSTION"
  elif [[ "$LANGUAGE" == "directory" ]];
  then 
    makeProjectDir 
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
  buildHeader $FILE
  if [[ "$HEADERFILE" != '' ]];
  then
    HEADER="${HEADER}\n#include \"$HEADERFILE\""
  elif [[ "$LANGUAGE" == 'java' ]];
  then
    HEADER="${HEADER}\nclass $NAME{"
  elif [[ $TEST -eq 1 ]];
  then
    HEADER="${HEADER}\ndescribe(\"Tests for $NAME\", () => { "
  fi
  buildFile $FILE $PATHTOCOPY
  if [[ "$LANGUAGE" == "bash" ]];
  then
    chmod +x "$FILE"
  fi
  echoC $G "Created ${B}$LANGUAGE${G} file: ${P}$FILE"
}

function buildHeaderFile() {
  HEADERFILE="$NAME.$HEADEREXTENSTION"
  checkForFile $HEADERFILE
  buildHeader $HEADERFILE
  local name=$(printf '%s\n' "$NAME" | awk '{ print toupper($0) }')
  local ext=$(printf '%s\n' "$HEADEREXTENSTION" | awk '{ print toupper($0) }')
  HEADER="${HEADER}\n#ifndef ${name}_${ext}\n"
  HEADER="${HEADER}#define ${name}_${ext}"
  buildFile $HEADERFILE $PATHTOHEADERCOPY
  echoC $G "Created ${B}$LANGUAGE${G} file: ${P}$HEADERFILE"
  HEADER=""
  buildBodyFile
  echoC $G "Created ${B}$LANGUAGE${G} files for: ${P}$NAME"
}

function buildHeader() {
  if [[ "$TOPCOMMENT" != "" ]];
  then
    HEADER="${HEADER}${PRESPACE}${TOPCOMMENT}\n"
  fi
  HEADER="${HEADER}${PRESPACE}${COMMENT}${SPACING}File: $1\n"
  HEADER="${HEADER}${PRESPACE}${COMMENT}${SPACING}Creator: $CREATOR\n"
  HEADER="${HEADER}${PRESPACE}${COMMENT}${SPACING}Created: $DATE\n"
  HEADER="${HEADER}${PRESPACE}${COMMENT}${SPACING}For: $FOR_COMMENT\n"
  HEADER="${HEADER}${PRESPACE}${COMMENT}${SPACING}Description $DESCRIPTION_COMMENT:"
  if [[ "$BOTTOMCOMMENT" != "" ]];
  then
    HEADER="${HEADER}\n${PRESPACE}${BOTTOMCOMMENT}"
  fi
  if [[ $LANGUAGE == "bash" ]];
  then
    HEADER="${HEADER}\n\nLOGFILE=\"$NAME.log\""
  fi
}

function buildFile() {
  touch "$1"
  echo -e "$HEADER" > "$1"
  cat "$2" >> "$1"
}

function makeProjectDir() {
  checkForDir $NAME
  mkdir $NAME
  echoC $G "Created ${B}$LANGUAGE${G}: ${P}$NAME/"
  cd $NAME
  main '-M'
  mkdir 'src'
  echoC $G "Created ${B}$LANGUAGE${G}: ${P}src/"
  mkdir 'bin'
  echoC $G "Created ${B}$LANGUAGE${G}: ${P}bin/"
  mkdir 'reports'
  echoC $G "Created ${B}$LANGUAGE${G}: ${P}reports/"
  mkdir 'tests'
  echoC $G "Created ${B}$LANGUAGE${G}: ${P}tests/"
  cd tests
  main '-b' 'test'
  cd ../bin
  main '-b' 'run'
  exit 0
}

function checkForDir() {
  checkForFile $NAME
  if [ -d "$NAME" ]; 
  then
    echoErr "${P}$NAME/${R} already exists"
    exit 1
  fi
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
    exit 1
  fi
else
  echoErr "Cannot find ${P}config.sh"
  echoErr "Current config path: ${P}$CONFIG"
  exit 1
fi

main $@
