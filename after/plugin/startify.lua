vim.g.startify_lists = {
   { type = 'dir',       header = {'   MRU ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p") } },
   { type = 'sessions',  header = {'   Sessions'}       },
   { type = 'bookmarks', header = {'   Bookmarks'}      },
   { type = 'commands',  header = {'   Commands'}       },
}
vim.g.startify_enable_special = 0
vim.g.startify_change_to_dir = 0
