-- カーソルを表示行で移動する。物理行移動は<C-n>, <C-p>
vim.keymap.set("n", "j", "gj", { noremap = true })
vim.keymap.set("n", "k", "gk", { noremap = true })
vim.keymap.set("n", "<Down>", "gj", { noremap = true })
vim.keymap.set("n", "<Up>", "gk", { noremap = true })

-- 日本語の行の連結時には空白を入力しない。
vim.opt.formatoptions:append("mM")

-- 画面最後の行をできる限り表示する。
vim.opt.display:append("lastline")

-- ステータスライン
vim.opt.laststatus = 2
vim.opt.statusline = [[%<%f %m %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%= (%v,%l)/%L%8P ]]
