require("config.lazy")

vim.opt.number = true
vim.opt.showmode = true
vim.opt.showmatch = true
-- 起動時のメッセージ非表示
vim.opt.shortmess = "I"
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = false
vim.opt.mouse = "a"

-- ========
-- キーマップ
-- ========
-- C-cをEscの代わりにする
vim.keymap.set('i', '<C-c>', "<Esc>", {noremap = true})
