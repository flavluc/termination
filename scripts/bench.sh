#!/bin/bash

. ./progress-bar.sh --source-only

ULTIMATE_DIR="../ultimate"
CONFIG_DIR="$ULTIMATE_DIR/config"
TOOLCHAIN_FILE="AutomizerTermination.xml"
SETTINGS_FILE="svcomp-Termination-64bit-Automizer_Default.epf"

if [ -z ${1+x} ] || [ -z ${2+x} ];
then
  echo "usage: $0 <path/to/dir> <timeout-in-secs>"
  exit 1
fi

FILES_DIR=$1
TIMEOUT_PARAM=$2
LOG_FILE="$FILES_DIR/log.csv"

echo "" > $LOG_FILE

count=0
total_files=$(find $FILES_DIR -type f -name "*.c" | wc -l)

for DIR in $FILES_DIR/*; do
  for FILE in $DIR/*; do
    
    if [ "${FILE: -2}" != ".c" ]
    then
      continue
    fi
    
    progress_bar $count $total_files
    
    RESULT="$($ULTIMATE_DIR/Ultimate -s $CONFIG_DIR/$SETTINGS_FILE -tc $CONFIG_DIR/$TOOLCHAIN_FILE --core.toolchain.timeout.in.seconds $TIMEOUT_PARAM  -i $FILE --generate-csv --csv-dir $DIR)"
    
    rm -rf "$HOME/.ultimate"
    
    FILENAME=${FILE##*/}
    CSV_DIR="${FILENAME}_${SETTINGS_FILE}_${TOOLCHAIN_FILE}"
    
    echo -e "$RESULT" > "$DIR/$CSV_DIR/${FILENAME:0:-2}.out"
    
    RESULT=$(echo "$RESULT" | grep RESULT)
    echo "$count => $RESULT" >> $LOG_FILE
    
    count=$(($count+1))
    
  done
done

progress_bar $count $total_files
echo -e "\n$count programs analized! Results are generated for each file."

