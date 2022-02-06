#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 14:17:02 2022
#   For: fileMaker
#   Description: Tests to make sure that fileMaker is working correctly

PROGRAM="/Users/rionduckworth/codeProjects/bash/fileMaker/src/fileMaker.sh"
FILENAME="example"
TESTDIR="testDir"
OPTIONS=( "-c" "-C" "-ch" "-Ch" "-j" "-p" "-m" "-b")

function main() {
   if [[ ! -d "$TESTDIR" ]];
   then
      mkdir "$TESTDIR"
   fi
   cd "$TESTDIR"
   if [[ $# == 0 ]];
   then
      testBuildAllValid
   else
      cd ..
      rm -r "$TESTDIR"
   fi
}

function testBuildAllValid() {
   for arg in "${OPTIONS[@]}"
   do
      testProgram "$arg" 
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

main $@
