case $- in
    *i*)  # interactive mode
        : ;;
    *)    # not interactive mode (scp, etc.)
        return ;;
esac
