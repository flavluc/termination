#!/bin/bash

# COUNTRY="Vatican City"

# case $COUNTRY in

#   Lithuania)
#     echo -n "Lithuanian"
#     t="a"
#   ;;

#   Romania | Moldova)
#     echo -n "Romanian"
#     t="b"
#   ;;

#   Italy | "San Marino" | Switzerland | "Vatican City")
#     echo -n "Italian"
#     t="c"
#   ;;

#   *)
#     echo -n "unknown"
#     t="d"
#   ;;
# esac

# echo -e "\n$t\n"

# timeout 2s result=$(echo "ola")

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
  local percent=$(( curr*100/total ))
  local curr_prog=$(( $percent/2 -1 ))
  local total_prog=$(( 50-$curr_prog-1))
  echo -ne "$(printf "%10s" "$percent%") [$(repeat "=" $curr_prog )>$(repeat " " $total_prog )] ($curr) $file\r"
}

# progress_bar 10 100 um_file
# sleep 0.5
# progress_bar 30 100 um_file
# sleep 0.5
# progress_bar 50 100 um_file
# sleep 0.5
# progress_bar 70 100 um_file
# sleep 0.5
# progress_bar 90 100 um_file
# sleep 0.5
# progress_bar 100 100 um_file
# echo -ne "\n"
# echo $(repeat "0" 1)

# total=$(ls "$1" | grep '\.c$' | wc -l)
# echo $total

printf "%-10s" "ola"

# echo -n "Old line"; echo -e "\e[0K\r new line"