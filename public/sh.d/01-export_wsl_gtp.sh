export WSL_DISTRO_NAME="{{.wsl}}"
export BROWSER="${HOME}/.local/bin/winopen"

# support Visual Studio Code
USERPROFILE="{{if .wsl_userprofile}}{{.wsl_userprofile}}{{else}}$(wslpath "$(/mnt/c/WINDOWS/system32/cmd.exe /c 'SET /P X=%USERPROFILE%<NUL' 2>/dev/null)"){{end}}"
export USERPROFILE
if [ -d "${USERPROFILE}/AppData/Local/Programs/Microsoft VS Code/bin" ]; then
  PATH="${PATH}:${USERPROFILE}/AppData/Local/Programs/Microsoft VS Code/bin"
fi
export PATH
