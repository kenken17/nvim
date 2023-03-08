local s_opts = { noremap = true, silent = true }

vim.g.agit_max_log_lines = 10000

vim.keymap.set("n", "<F12>", ":Agit<Cr>", s_opts)
vim.keymap.set("n", "<Leader><F12>", ":AgitFile<Cr>", s_opts)
