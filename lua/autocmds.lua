local api = vim.api

-- show cursor line only in active window
local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })

api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, { pattern = "*", command = "set cursorline", group = cursorGrp })
api.nvim_create_autocmd(
	{ "InsertEnter", "WinLeave" },
	{ pattern = "*", command = "set nocursorline", group = cursorGrp }
)

-- when resize make windows equal size
api.nvim_create_autocmd("VimResized", {
	pattern = "*",
	command = 'execute "normal \\<C-w>="',
})

-- go to last loc when opening a buffer
api.nvim_create_autocmd(
	"BufReadPost",
	{ command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

-- don't auto comment new line
api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Open log in quicklist window
api.nvim_create_autocmd("QuickFixCmdPost", { command = [[*grep* cwindow]] })


-- turn on spell check when text or markdown
api.nvim_create_autocmd(
	{ "BufWinEnter" },
	{ pattern = "*.md,*.txt", command = 'if spelunker#toggle#is_enabled() == 0 | call spelunker#toggle_buffer() | endif' }
)

