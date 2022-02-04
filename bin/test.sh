#!/bin/bash
#   Creator: Ernest M Duckworth IV
#   Date: Thu Feb  3 14:17:02 2022
#   For: fileMaker
#   Description: Tests to make sure that fileMaker is working correctly

PROGRAM="/Users/rionduckworth/codeProjects/bash/fileMaker/src/fileMaker.sh"
FILENAME="example"

function main() {
   mkdir "test"
   cd "test"
   $PROGRAM "-ch" $FILENAME 
   $PROGRAM "-Ch" $FILENAME 
   $PROGRAM "-j" $FILENAME 
   $PROGRAM "-p" $FILENAME 
   $PROGRAM "-m" $FILENAME 
   $PROGRAM "-b" $FILENAME 
}

main
