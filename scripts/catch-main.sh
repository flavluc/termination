#!/bin/bash

. ./progress-bar.sh --source-only

LIB_FILE="../build/lib/libcatch-main.so"
LIB_FLAG=-catch-main
BC_FILE=tmp.bc

touch $BC_FILE

if [ -z ${1+x} ];
then
  echo "usage: $0 <path/to/dir>"
  exit 1
fi

FILES_DIR="$1"
DIRNAME=${FILES_DIR##*/}

catch_main () {
  clang -emit-llvm -c $1 -o $BC_FILE
  RESULT="$(opt -load $LIB_FILE $LIB_FLAG -disable-output $BC_FILE)"
  
  if [ "$RESULT" == "1" ]
  then
    local DIR="$DIRNAME-main-fns"
    mkdir -p $DIR
    cp $1 $DIR
  fi
}

count=0
total_files=$(find $FILES_DIR -type f -name "*.c" | wc -l)

for file in `find $FILES_DIR -type f -name "*.c"`; do
  if [ ${file: -2} == ".c" ]
  then
    catch_main $file
    count=$(($count+1))
    
    progress_bar $count $total_files
  fi
done

rm $BC_FILE

echo -e "\n$count programs analized"