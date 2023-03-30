local s_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F7>", "[c", s_opts)
vim.keymap.set("n", "<F8>", "]c", s_opts)
vim.keymap.set("n", "<F10>", ":Git pull<Cr>", s_opts)
vim.keymap.set("n", "<F11>", ":Git push<Cr>", s_opts)
