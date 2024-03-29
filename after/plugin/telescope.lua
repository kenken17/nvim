local status_ok, telescope = pcall(require, "telescope")

if not status_ok then
	return
end

local s_opts = { noremap = true, silent = true }

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")

vim.keymap.set(
	"n",
	"<F3>",
	"<cmd>lua require'telescope.builtin'.find_files(require'telescope.themes'.get_dropdown({ previewer = false }))<Cr>",
	s_opts
)
vim.keymap.set(
	"n",
	"<C-f>",
	"<cmd>lua require'telescope.builtin'.find_files(require'telescope.themes'.get_dropdown({ previewer = false }))<Cr>",
	s_opts
)
vim.keymap.set(
	"n",
	"<F4>",
	"<cmd>lua require'telescope.builtin'.git_files(require'telescope.themes'.get_dropdown({ previewer = false }))<Cr>",
	s_opts
)
vim.keymap.set("n", "<leader>fg", builtin.live_grep, s_opts)
vim.keymap.set("n", "<leader>fs", builtin.grep_string, s_opts)
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, s_opts)

telescope.setup({
	defaults = {
		-- Default configuration for telescope goes here:
		-- config_key = value,
		mappings = {
			i = {
				["<C-j>"] = { actions.move_selection_next, type = "action", opts = { nowait = true, silent = true } },
				["<C-k>"] = {
					actions.move_selection_previous,
					type = "action",
					opts = { nowait = true, silent = true },
				},
				["<F2>"] = actions.close,
				["<Esc>"] = actions.close,
				["<C-i>"] = actions.file_split,
				["<C-s>"] = actions.file_vsplit,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
		["ui-select"] = {
			require("telescope.themes").get_dropdown({}),
		},
	},
})

require("telescope").load_extension("ui-select")
require("telescope").load_extension("neoclip")
