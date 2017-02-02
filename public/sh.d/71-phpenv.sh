if [[ -d ~/.phpenv ]]; then
  export PATH=~/.phpenv/bin:"$PATH"
  eval "$(phpenv init -)"
fi
