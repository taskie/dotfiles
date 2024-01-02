# extract

function extract() {
    case "$1" in
        *.tar.gz|*.tgz) tar xzvf "$1" ;;
        *.tar.xz) tar Jxvf "$1" ;;
        *.tar.zst) tar --zstd xvf "$1" ;;
        *.zip) unzip "$1" ;;
        *.lzh) lha e "$1" ;;
        *.tar.bz2|*.tbz) tar xjvf "$1" ;;
        *.tar.Z) tar zxvf "$1" ;;
        *.gz) gzip -dc "$1" ;;
        *.bz2) bzip2 -dc "$1" ;;
        *.Z) uncompress "$1" ;;
        *.tar) tar xvf "$1" ;;
        *.arj) unarj "$1" ;;
        *.zst) zstd -dc "$1" ;;
    esac
}

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,zst}=extract

# mkcd

function mkcd() {
    mkdir -p "$1" && cd "$1"
}
