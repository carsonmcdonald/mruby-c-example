#!/bin/bash

for bin_test in "$@"
do
  echo -n "${bin_test}: "
  ./$bin_test > /tmp/$bin_test.tst 2>&1
  diff /tmp/$bin_test.tst test_output/$bin_test.tst > /dev/null 2>&1
  if [ $? -eq 0 ]
  then
    echo -e "\xE2\x9c\x93"
  else
    echo -e "\xE2\x98\xA0"
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
