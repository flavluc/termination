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

RESULT="$(cat temp.txt)"

RESULT=$(echo "$RESULT" | grep RESULT)

echo "$RESULT"