#!/bin/bash

BASEDIR=$(pwd)
LIB_FILE="$BASEDIR/../build/lib/libnested-loop-counter.so"
LIB_FLAG=-nested-loop-counter
BC_FILE=tmp.bc
RBC_FILE=tmp.rbc
LOG_FILE=log.txt

if [ -z ${FILES_DIR+x} ];
then
  echo "usage: FILES_DIR=<path/to/dir> $0"
  exit 1
fi

NOW="$(date +"%y-%m-%dT%H:%M:%SZ")"
RESULTS_DIR="results/$NOW"
mkdir -p $RESULTS_DIR

classify_nested_loop () {
  echo "running for: $1"
  clang -emit-llvm -c $1 -o $BC_FILE &>> $RESULTS_DIR/$LOG_FILE
  opt -mem2reg $BC_FILE -o $RBC_FILE &>> $RESULTS_DIR/$LOG_FILE
  RESULT="$(opt -load $LIB_FILE $LIB_FLAG -disable-output $RBC_FILE)"
  mkdir -p $RESULTS_DIR/$RESULT
  cp $1 $RESULTS_DIR/$RESULT
}

count=0

for file in $FILES_DIR/*; do
  if [ ${file: -2} == ".c" ]
  then
    classify_nested_loop $file
    count=$(($count+1))
  else
    echo "not a valid C file: $file"
  fi
done

rm $BC_FILE
rm $RBC_FILE

echo "$count programs analized"