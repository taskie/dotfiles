if [[ -d ~/.pyenv ]]; then
    export PYENV_ROOT="${HOME}/.pyenv"
    if [ -n ${PYENV_ROOT} ]; then
	path=(${PYENV_ROOT}/bin ${PYENV_ROOT}/shims ${path})
    fi
    eval "$(pyenv init - zsh)"
fi
