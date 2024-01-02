{{if .tfenv}}
export PATH="${HOME}/.tfenv/bin:${PATH}"
{{end}}

{{if .phpenv}}
export PATH="${HOME}/.phpenv/bin:${PATH}"
eval "$(phpenv init -)"
{{end}}

{{if .rbenv}}
export PATH="${HOME}/.rbenv/bin:${PATH}"
eval "$(rbenv init -)"
{{end}}

{{if .sdkman}}
export SDKMAN_DIR="${HOME}/.sdkman"
[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ] && . "${HOME}/.sdkman/bin/sdkman-init.sh"
{{end}}

{{if .nvm}}
export NVM_DIR="${HOME}/.nvm"
. "${NVM_DIR}/nvm.sh"
{{end}}

{{if .cargo}}
. "${HOME}/.cargo/env"
{{end}}

{{if .pyenv}}
export PYENV_ROOT="${HOME}/.pyenv"
export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init --path)"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi
{{end}}

{{if .poetry}}
export PATH="${HOME}/.poetry/bin:${PATH}"
{{end}}
