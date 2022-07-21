a=11
remainder=$(($a % 2))
half=$(($a/2))

if [ $remainder -eq 0 ]
#if [ $a -eq 0 ]
then
  echo "$a can be divided by 2"
  echo $half
else
  echo "$a cannot be divided by 2"
  echo $half
fi

YSIZE=2
YSIZE_loop=$(($YSIZE*2))
echo $YSIZE_loop
