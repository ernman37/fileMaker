#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 14:17:02 2022
#   For: 
#   Description: 

#Colors
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PINK='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPINK='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

function main() {
   fileMaker.sh 
   fileMaker.sh "-asdf" 
   fileMaker.sh "-as" "dfs"
   fileMaker.sh "-j" "-d" "file"
   fileMaker.sh "-m" "file"
}

function echoColor() {
   echo -e "${1}$2${NO}"
}

main
