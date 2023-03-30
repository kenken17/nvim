local s_opts = { noremap = true, silent = true }

vim.g["gina#command#blame#formatter#format"] = "%su%=on (%au) - (%ti)"

vim.keymap.set("n", "<Leader><F9>", ":Gina blame --width=100<Cr>", s_opts)
