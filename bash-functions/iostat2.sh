#----------------------------------------------------------------------
# iostat command overlap
#
#   Filter command output on bypass first sample of data, that was the 
#   accumulated result from system boot time and its not relevant.
#
function iostat2() {
  FILTER=$(iostat -x 1 1 |wc -l)
  iostat ${@} |tail -n +$((FILTER+1))
}
