---
name: preview-replacement
description: Preview bulk text replacements across multiple files as a unified diff without modifying any files. Use when the user asks to "preview a replacement", "dry-run a find and replace", "show diff for search and replace", or wants to verify substitution results before applying.
user-invocable: true
argument-hint: [PATTERN] [REPLACEMENT_TEXT] [RG_ARGS...]
---

# Preview Bulk Replacements

`rgdiff` outputs a unified diff for a regex replacement across files, without modifying anything.

```sh
rgdiff PATTERN REPLACEMENT_TEXT [RG_ARGS...]
```

- `PATTERN` — regex pattern (ripgrep syntax)
- `REPLACEMENT_TEXT` — replacement string (supports capture groups like `$1`)
- `RG_ARGS...` — additional `rg` arguments (e.g., `-g '*.ts'`, path filters)

## When to use this instead of Edit

Use `rgdiff` + `patch` when the same mechanical replacement applies to many files (e.g., renaming an identifier, updating an import path). Use the Edit tool for context-dependent changes that differ per file.

## Workflow

1. Run `rgdiff` to preview the diff
2. Show the output to the user
3. If the user approves, apply with `rgdiff PATTERN REPLACEMENT_TEXT [RG_ARGS...] | patch -p0`

When invoked as `/preview-replacement` with arguments, run step 1 directly:

```sh
rgdiff $ARGUMENTS
```
