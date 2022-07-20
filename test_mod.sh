a=9
remainder=$((a % 2))

if [ $remainder -eq 0 ]
#if [ $a -eq 0 ]
then
  echo "$a can be divided by 2"
else
  echo "$a cannot be divided by 2"
fi
