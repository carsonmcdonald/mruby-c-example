#!/bin/bash

for bin_test in "$@"
do
  echo -n "${bin_test}: "
  ./$bin_test > /tmp/$bin_test.tst 2>&1
  diff /tmp/$bin_test.tst test_output/$bin_test.tst > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo -e "\033[1;32m\xE2\x9c\x93\033[1;0m"
  else
    echo -e "\033[1;31m\xE2\x98\xA0\033[1;0m"
    echo "**************"
    echo "Expected: "
    cat test_output/$bin_test.tst
    echo "**************"
    echo "Got: "
    cat /tmp/$bin_test.tst
    echo "**************"
  fi
  rm -f /tmp/$bin_test.tst
done
