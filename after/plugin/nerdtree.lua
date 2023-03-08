local s_opts = { noremap = true, silent = true }

vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 50
vim.g.NERDTreeAutoDeleteBuffer = 1
vim.g.NERDTreeMinimalUI = 1
vim.g.NERDTreeQuitOnOpen = 1
vim.g.NERDTreeIgnore = { 'dist$', '.git$', 'node_modules$', '.vscode', '.idea$', 'coverage$' }

vim.keymap.set("n", "<Leader><Space>", ":NERDTreeFind<Cr>", s_opts)
