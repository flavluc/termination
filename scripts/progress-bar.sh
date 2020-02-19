repeat() {
  if [ $2 -gt 0 ]
  then
    printf "$1"'%.s' $(seq 1 $2)
  fi
}

progress_bar(){
  local curr=$1
  local total=$2
  
  local percent=$(( curr*100/total ))
  local curr_prog=$(( $percent/2 ))
  local total_prog=$(( 50-$curr_prog-1))
  
  echo -ne "$(printf "%10s" "$percent%") [$(repeat "=" $curr_prog )>$(repeat " " $total_prog )] ($curr/$total)\r"
}

export -f progress_bar