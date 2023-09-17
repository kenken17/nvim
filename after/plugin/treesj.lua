local treesj_status, treesj = pcall(require, "treesj")

if not treesj_status then
	return
end

treesj.setup({})

vim.keymap.set("n", "<leader>m", require("treesj").toggle)
