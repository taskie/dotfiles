---
name: bulk-rename-files
description: Bulk rename files safely with zsh zmv using dry-run first, then apply after confirmation. Use when the user asks to rename many files by filename pattern (prefix/suffix/extension) in one shot.
user-invocable: true
argument-hint: '[BEFORE_GLOB] [AFTER_GLOB]'
---

# Bulk File Renames With zmv

Use `zsh` + `zmv` to rename many files by filename pattern.

```sh
zsh -ic 'autoload -Uz zmv; zmv -nW "$1" "$2' 0 "$BEFORE_GLOB" "$AFTER_GLOB"
```

- `-n` : dry-run (preview only, no files are changed)
- `-W` : keeps replacement behavior explicit for this template-style rename
- Quote both globs so wildcard expansion is done by `zmv` (not by the interactive shell before execution)
- Pass values via positional args (`$1`, `$2`) so special chars are safely preserved when quoted

## Example

```sh
zsh -ic 'autoload -Uz zmv; zmv -nW "$1" "$2"' _ "**/Before*.java" "**/After*.java"
```

Apply after preview:

```sh
zsh -ic 'autoload -Uz zmv; zmv -W "$1" "$2"' _ "**/Before*.java" "**/After*.java"
```
