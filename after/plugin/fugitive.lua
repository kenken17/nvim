local opts = { noremap = true }
local s_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F9>", ":Git<Cr>:15wincmd_<Cr>", s_opts)
vim.keymap.set("n", "<F10>", ":Gvdiffsplit<Space>", opts)
vim.keymap.set("n", "<F11>", ":Git pull<Cr>", s_opts)
vim.keymap.set("n", "<Leader><F11>", ":Git push<Cr>", s_opts)
