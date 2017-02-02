PATH=~/usr/bin:"$PATH"
export PATH

if [ -x /opt/intel/bin/compilervars.sh ]; then
    source /opt/intel/bin/compilervars.sh intel64
fi
