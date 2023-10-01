local status_ok, nvim_tree = pcall(require, "nvim-tree")

if not status_ok then
	return
end

local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "gy", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "Y", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
end

-- pass to setup along with your other options
nvim_tree.setup({
	sort_by = "case_sensitive",
	view = {
		width = 45,
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
	},
	on_attach = my_on_attach,
})

vim.keymap.set("n", "<Leader><Space>", ":NvimTreeFindFileToggle()<CR>", { noremap = true })
