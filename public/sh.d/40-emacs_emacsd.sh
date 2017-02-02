if pgrep -f '[Ee]macs' >/dev/null 2>&1; then
    : # Emacs server is already running
else
    `emacs --daemon`
fi
