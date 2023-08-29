local opts = { noremap = true }
local s_opts = { noremap = true, silent = true }
local map = vim.keymap.set

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Fix the accidental Q
map("n", "Q", "<Nop>", s_opts)

-- <Space> to repeat
map("n", "<Space>", ".", s_opts)

-- Help
map("n", "<F1>", ":help <C-r><C-w><Cr>", s_opts)

-- Quit
map("n", "<F2>", ":lua CloseOut()<Cr>", s_opts)
map("n", "<Leader><F2>", ":tabclose<Cr>", s_opts)

-- Resize with arrows
map("n", "<S-h>", ":vertical resize -2<Cr>", s_opts)
map("n", "<S-l>", ":vertical resize +2<Cr>", s_opts)

-- Y to copy a line, why not right?
map("n", "Y", "yy", s_opts)
map("n", "D", "d$", s_opts)

-- Turn off all highlights
map("n", "<Leader>/", ":nohlsearch<Cr>", s_opts)

-- When a forward search, back to current search item with center
map("n", "*", "*Nzz", s_opts)
map("n", "#", "#Nzz", s_opts)
map("n", "n", "nzz", s_opts)
map("n", "N", "Nzz", s_opts)

-- For quick vsplit diff
map("n", "<Leader>d", ":windo diffthis<Cr>", s_opts)
map("n", "<Leader>D", ":diffoff<Cr>", s_opts)

-- In/Out/Up/Down with center
map("n", "<C-o>", "<C-o>zz", s_opts)
map("n", "<C-i>", "<C-i>zz", s_opts)
map("n", "<C-d>", "<C-d>zz", s_opts)
map("n", "<C-u>", "<C-u>zz", s_opts)

-- Search
map("n", "<Leader>*", ":Rg --ignore-file ~/.rgignore -S -F '<C-r><C-w>'", opts)
map("n", "<Leader>a", ":Rg --ignore-file ~/.rgignore -S -F ''<Left>", opts)

-- Join wihtout moving the cursor
map("n", "J", "mzJ`z", s_opts)

-- Move up and down between virtual line
map("n", "j", "gj", s_opts)
map("n", "k", "gk", s_opts)

-- Set comma above the line
map("n", "<Leader>,", "mpk$A,<esc>`p", s_opts)

-- Crude search count and replace
map("n", "<Leader>ff", ":%sno/<C-r><C-w>//gn<Cr>", s_opts)
map("n", "<Leader>fr", ":%sno/<c-r><C-w>//gc<Left><Left><Left>", opts)

-- Reset the current file
map("n", "<Leader><Del>", ":! git checkout HEAD -- %<Cr>", s_opts)

-- Move along
map("v", "J", ":m '>+1<Cr>gv=gv", s_opts)
map("v", "K", ":m '<-2<Cr>gv=gv", opts)

-- Keep the highlight when indent
map("v", ">", ">gv", s_opts)
map("v", "<", "<gv", s_opts)

-- Send the paste item to primary
map("v", "<Leader>Y", '"*y')

-- Send the paste item to clipboard
map("v", "<Leader>y", '"+y')

-- For making toc for markdown, need markdown-toc
map("n", "<Leader>mt", ':!markdown-toc -i %<CR>', opts)

-- Open up NERDTree
map("n", "<Leader><Space>", ':lua OpenNERDTree()<CR>', opts)

-- For self define function
-- ------------------------
-- Close tab or quit
function CloseOut()
	local is_plugin_ui = vim.fn.winnr("$") == 1
	local win_config = vim.api.nvim_win_get_config(0)
	local is_floating = win_config.relative == "editor"
	local is_special = vim.bo.filetype == "nerdtree"
			or vim.bo.filetype == "help"
			or vim.bo.filetype == "packer"
			or vim.bo.filetype == "fugitiveblame"
			or vim.bo.filetype == "git"
			or vim.bo.filetype == "qf"
			or vim.bo.filetype == "startify"

	if is_special or is_plugin_ui or is_floating then
		vim.cmd("q")
	else
		if vim.api.nvim_get_mode()["mode"] == "n" then
			if vim.bo.buflisted then
				vim.cmd("q")
			elseif vim.api.nvim_tabpage_is_valid(0) then
				vim.cmd("tabclose")
			end
		end
	end
end

-- Open NERDTree
function OpenNERDTree()
	local is_startify = vim.bo.filetype == "startify"

	if is_startify then
		vim.cmd("NERDTree")
	else
		vim.cmd("NERDTreeFind")
	end
end
