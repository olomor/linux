# Compress a file folder to an tar gzip file through many processors
# using the 'pigz' utility coupled by pipeline.
function tarpigz() {
  if [[ "$1" == "" || "$2" == "" ]]; then echo "Usage: $FUNCNAME <<DestinationCompressedTarGzFile>> <<SourceDirOrFilename>>" ; return 1 ; fi
  if [[ ! -e "$2" ]]; then echo "Error: source file/folder '$2' not found."; return 1 ; fi
  BLOCKSIZE=$( grep "^cache size" /proc/cpuinfo |uniq |cut -d" " -f3 ) || return 1
  NUMCPU=$(nproc) || return 1
  PIGZ="pigz --best --blocksize ${BLOCKSIZE} --independent --processes $((NUMCPU/2)) --synchronous"
  time tar -cvf - ${2} |$PIGZ >${1}
}
