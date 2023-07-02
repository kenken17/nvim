-- No mouse
-- vim.opt.mouse = nil

-- Nice Color
vim.opt.termguicolors = true

-- Line number always
vim.opt.number = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Cursorline
vim.opt.cursorline = true

-- Use spaces for tab
vim.opt.expandtab = true

-- indent spaces
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

-- 99 fold levels
vim.opt.foldlevel = 100
vim.opt.foldmethod = "indent"

-- No need backup and swap
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- No wrap
vim.opt.wrap = true
vim.opt.linebreak = true -- companion to wrap, don't split words
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Case insensitive and indent
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true

-- Searching
vim.opt.hlsearch = true

-- split
-- vim.opt.splitbelow = true
-- vim.opt.splitright = true

-- Undos
vim.opt.undofile = true
vim.opt.backupdir = os.getenv("HOME") .. "/.vim_backups"
vim.opt.undodir = os.getenv("HOME") .. "/.vim_undos"

-- for opening diff
vim.opt.diffopt = "internal,filler,closeoff,vertical"

-- Faster response
vim.opt.timeoutlen = 500
vim.opt.updatetime = 800

-- we don't need to see things like -- INSERT -- anymore
vim.opt.showmode = false
