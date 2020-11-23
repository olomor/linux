# Number of online processors, same as 'cat /proc/cpuinfo'
nproc () { 
    [[ $OSTYPE == *linux* ]] && getconf _NPROCESSORS_ONLN
}
