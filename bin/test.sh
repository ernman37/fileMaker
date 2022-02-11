#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 14:17:02 2022
#   For: fileMaker
#   Description: Tests to make sure that fileMaker is working correctly

#Color for Output 
NO='\033[0m'
R='\033[0;31m'
G='\033[0;32m'
O='\033[0;33m'
P='\033[0;35m'
B='\033[0;36m'

PROGRAM="/Users/rionduckworth/codeProjects/bash/fileMaker/src/fileMaker.sh"
FILENAME="example"
TESTDIR="testDir"
OPTIONS=( "ch" "Ch" "c" "C" "j" "p" "m" "b" "H" "s" "js" "jst" "t" "tt" "M")

function main() {
   deleteIfDirExists
   testBuildAllValid
}

function deleteIfDirExists() {
   if [[ ! -d "$TESTDIR" ]];
   then
      mkdir "$TESTDIR"
      cd "$TESTDIR"
   else
      rm -r $TESTDIR
      exit $?
   fi
}

function testBuildAllValid() {
   echoC $O "Testing All Valid"
   for arg in "${OPTIONS[@]}"
   do
      testProgram "-$arg" 
   done
}

function testProgram() {
   local testFile="$FILENAME"
   if [[ $# == 2 ]];
   then
      testFile="$2"
   fi
   $PROGRAM "$1" "$testFile"
}

function echoC() {
   echo -e "${1}$2${NO}"
}

main $@
