cdg() {
	cd "$(git rev-parse --show-toplevel)" || return 1
}
