-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4

-- Mouse
vim.opt.mouse = "a"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Wildmenu
vim.opt.wildmenu = true
vim.opt.wildmode = "list:full"

-- Matching
vim.opt.showmatch = true
vim.opt.matchtime = 1

-- Cursor line
vim.opt.cursorline = true
vim.api.nvim_set_hl(0, "StatusLine", { ctermfg = "Black", ctermbg = "Gray" })
vim.api.nvim_set_hl(0, "CursorLine", { ctermbg = 153 })

-- Completion
vim.opt.completeopt = "menu"

-- Auto write
vim.opt.autowrite = true
