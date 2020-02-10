#!/bin/bash

terminating="RESULT: Ultimate proved your program to be correct!"
nonterminating="RESULT: Ultimate proved your program to be incorrect!"
unable="RESULT: Ultimate could not prove your program: unable to determine termination"
invalid="RESULT: Ultimate could not prove your program: Toolchain returned no result."
timeout="RESULT: Ultimate could not prove your program: Timeout"

ULTIMATE_DIR="../ultimate"
TIMEOUT_PARAM="100s"

if [ -z ${1+x} ];
then
  echo "usage: $0 <path/to/dir>"
  exit 1
fi

FILES_DIR=$1
LOG_FILE="$FILES_DIR/log.csv"

# basic_blocks? branches? ???
echo "nested_loops;termination;time" > $LOG_FILE

count=0

for DIR in $FILES_DIR/*; do
  for FILE in $DIR/*; do
    
    if [ "${FILE: -2}" != ".c" ]
    then
      continue
    fi
    
    filename=${FILE##*/}
    nested_loops=${DIR##*/}
    
    echo "running for $FILE"
    
    ts=$(date +%s%N)
    
    RESULT="$(timeout $TIMEOUT_PARAM $ULTIMATE_DIR/Ultimate -s $ULTIMATE_DIR/config/svcomp-Termination-64bit-Automizer_Default.epf -tc $ULTIMATE_DIR/config/AutomizerTermination.xml -i $FILE)"
    
    rc=$?
    
    elapsed=$((($(date +%s%N) - $ts) / 1000000)) # time in milliseconds
    
    echo -e "$RESULT" > "${FILE:0:-2}.out"
    
    if [ $rc == 124 ]
    then
      RESULT=$timeout
    else
      RESULT=$(echo "$RESULT" | grep RESULT)
    fi
    
    case $RESULT in
      
      $terminating)
        termination="terminating"
      ;;
      $nonterminating)
        termination="nonterminating"
      ;;
      $unable)
        termination="unable"
      ;;
      $invalid)
        termination="invalid"
      ;;
      $timeout)
        termination="timeout"
      ;;
      *)
        echo -e "an error occurred while running for $FILE\n$RESULT"
        termination="error"
      ;;
    esac
    
    echo "$nested_loops;$termination;$elapsed;$filename" >> $LOG_FILE
    count=$(($count+1))
    
  done
done

echo "$count programs analized, results generated at $LOG_FILE"
