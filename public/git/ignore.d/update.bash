#!/bin/bash
set -u

BASE_URL=https://raw.githubusercontent.com/github/gitignore/main/Global

find . -name '*.gitignore' | xargs -r -I '{}' basename '{}' .gitignore | while read -r name; do
  nomod_name="$(cut -d _ -f 1 <<<"$name")"
  url="${BASE_URL}/${nomod_name}.gitignore"
  curl -fsSL "$url" -o "${name}.gitignore" || echo "FAILED: ${url}"
done

sed -i -E 's/^(tags|dist)\b/# \1/' *.gitignore
