function dd-perf-test-mb() {
  if [[ "$1" == "" ]]; then echo "Usage: $FUNCNAME <<DestinationFolder>> <<TestTotalMB:Default100>>"; return 1 ; fi
  export TESTFILENAME="${1}/dd-perf-test.dat.$(date +'%s').tmp"
  SIZEMB=${2:-100}
  if [[ "${2}" =~ [[:alpha:],\.] ]]; then echo "ERROR: Invalid test size '${2}'. Use numbers only." ; return 1 ; fi
  DESTFREEMB=$(df -m --output=avail /tmp |tail -1)
  if [[ DESTFREEMB -le SIZEMB ]]; then echo "FAIL: Insufficient space at destination.">&2; echo "Destination '${1}' has only $DESTFREEMB MB available, needs $SIZEMB MB for create a temporary a test file." ; return 1 ; fi
  OUTPUT=$(dd if=/dev/zero of="${TESTFILENAME}" bs=1M count=${SIZEMB} 2>&1) \
    || echo "$OUTPUT" \
    && echo "$OUTPUT" |tail -1 |rev |cut -d' ' -f1-2 |rev
  [[ -e "${TESTFILENAME}" ]] && rm -f "${TESTFILENAME}"
}
