#!/bin/bash

LIB_FILE="../build/lib/libfilter-programs.so"
LIB_FLAG=-filter-programs
BC_FILE=tmp.bc
RBC_FILE=tmp.rbc
LOG_FILE=log.txt

touch $BC_FILE
touch $RBC_FILE

if [ -z ${1+x} ];
then
  echo "usage: $0 <path/to/dir>"
  exit 1
fi

NOW="$(date +"%y-%m-%dT%H:%M:%SZ")"
FILES_DIR="$1"
RESULTS_DIR="../results/$NOW"
mkdir -p $RESULTS_DIR

repeat() {
  if [ $2 != 0 ]
  then
    printf "$1"'%.s' $(seq 1 $2)
  fi
}

progress_bar(){
  local curr=$1
  local total=$2
  local file=$3
  
  (( ${#file} > 50 )) && name="${name:0:47}..."
  
  local percent=$(( curr*100/total ))
  local curr_prog=$(( $percent/2 -1 ))
  local total_prog=$(( 50-$curr_prog-1))
  
  echo -ne "$(printf "%10s" "$percent%") [$(repeat "=" $curr_prog )>$(repeat " " $total_prog )] ($curr) $(printf "%-130s" "$file")\r"
}

classify_nested_loop () {
  clang -emit-llvm -c $1 -o $BC_FILE &>> $RESULTS_DIR/$LOG_FILE
  opt -mem2reg $BC_FILE -o $RBC_FILE &>> $RESULTS_DIR/$LOG_FILE
  RESULT="$(opt -load $LIB_FILE $LIB_FLAG -disable-output $RBC_FILE)"
  
  if [ "$RESULT" != "-1" ]
  then
    mkdir -p $RESULTS_DIR/$RESULT
    cp $1 $RESULTS_DIR/$RESULT
  fi
}

count=0
total_files=$(ls "$FILES_DIR" | grep '\.c$' | wc -l)

for file in $FILES_DIR/*; do
  if [ ${file: -2} == ".c" ]
  then
    classify_nested_loop $file
    count=$(($count+1))
    
    filename=${file##*/}
    progress_bar $count $total_files $filename
  fi
done

rm $BC_FILE
rm $RBC_FILE

echo -e "\n$count programs analized"