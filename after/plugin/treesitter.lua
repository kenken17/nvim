local status_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")

if not status_ok then
	return
end

nvim_treesitter_configs.setup({
	-- A list of parser names, or "all" (the four listed parsers should always be installed)
	ensure_installed = { "bash", "lua", "vim", "help", "javascript", "typescript" },
	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,
	-- Automatically install missing parsers when entering buffer
	-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
	auto_install = true,
	highlight = {
		enable = true,
		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	disable = function(_, buf) -- first arg is `lang` not in use for now
		local max_filesize = 100 * 1024 -- 100 KB
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		if ok and stats and stats.size > max_filesize then
			return true
		end
	end,
})
