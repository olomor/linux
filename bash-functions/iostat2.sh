function iostat2() {
  FILTER=$(iostat -x 1 1 |wc -l)
  iostat ${@} |tail -n +$((FILTER+1))
}
