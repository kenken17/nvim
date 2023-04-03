local status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok then
	return
end

gitsigns.setup({
	signs     = {
		add = { text = "▏" },
		change = { text = "▏" },
		delete = { text = "▶" },
		topdelete = { text = "▶" },
		changedelete = { text = "▏" },
		untracked = { text = "▏" },
	},
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map('n', '<F8>', function()
			if vim.wo.diff then return ']c' end
			vim.schedule(function() gs.next_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		map('n', '<F7>', function()
			if vim.wo.diff then return '[c' end
			vim.schedule(function() gs.prev_hunk() end)
			return '<Ignore>'
		end, { expr = true })

		-- Actions
		map({ 'n', 'v' }, '<Leader>-', ':Gitsigns stage_hunk<CR>')
		map('n', '<F10>', gs.diffthis)
	end
})
