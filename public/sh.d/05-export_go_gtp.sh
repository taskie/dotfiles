{{if .goroot}}
export GOROOT="{{.goroot}}"
export PATH="${GOROOT}/bin:${PATH}"
{{end}}
export GOPATH="${HOME}/go"
export PATH="${GOPATH}/bin:${PATH}"
