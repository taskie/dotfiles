if pgrep '[Ee]macs' || emacsclient -e '(version)' >/dev/null 2>&1; then
    : # Emacs server is already running
else
    `emacs --daemon`
fi
