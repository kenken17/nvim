local status_ok, null_ls = pcall(require, "null-ls")

if not status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover

null_ls.setup({
	sources = {
		-- formatting["prettierd"],
		-- diagnostics["prettierd"],
		-- completion["prettierd"],
		-- code_actions["prettierd"],
		-- hover["prettierd"],

		formatting["prettierd"],

		diagnostics["yamllint"],

		formatting["markdown_toc"],
	},
})
