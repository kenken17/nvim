local s_opts = { noremap = true, silent = true }

vim.g["test#strategy"] = {
  nearest = 'neovim',
  all = 'vimux',
  suite = 'vimux',
  file = 'vimux',
  last = 'neovim',
}

vim.g["test#javascript#runner"] = 'jest'

-- For setting test runner
vim.keymap.set("n", "<Leader>t", ":TestFile --watch<Cr>", s_opts)
