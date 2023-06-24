local status_ok, diffview = pcall(require, "diffview")

if not status_ok then
	return
end

local actions = require("diffview.actions")

diffview.setup({
	show_help_hints = false, -- Show hints for how to open the help panel
	use_icons = false,
	signs = {
		fold_closed = "▶ ",
		fold_open = "▼ ",
		done = "✓ ",
	},
	view = {
		merge_tool = {
			-- Config for conflicted files in diff views during a merge or rebase.
			layout = "diff3_mixed",
			disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
			winbar_info = true,      -- See |diffview-config-view.x.winbar_info|
		},
	},
	file_panel = {
		listing_style = "tree", -- One of 'list' or 'tree'
		tree_options = {
			-- Only applies when listing_style is 'tree'
			flatten_dirs = false,         -- Flatten dirs that only contain one single dir
			folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
		},
		win_config = {
			-- See ':h diffview-config-win_config'
			position = "left",
			width = 35,
			win_opts = {},
		},
	},
	file_history_panel = {
		win_config = {
			-- See ':h diffview-config-win_config'
			position = "top",
			height = 30,
			win_opts = {},
		},
	},
	keymaps = {
		disable_defaults = true, -- Disable the default keymaps
		view = {
			-- The `view` bindings are active in the diff buffers, only when the current
			-- tabpage is a Diffview.
			{ "n", "<tab>",     actions.select_next_entry, { desc = "Open the diff for the next file" } },
			{ "n", "<s-tab>",   actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
			{ "n", "<Leader>e", actions.focus_files,       { desc = "Bring focus to the file panel" } },
			{ "n", "<Leader>b", actions.toggle_files,      { desc = "Toggle the file panel." } },
			{ "n", "g<C-x>",    actions.cycle_layout,      { desc = "Cycle through available layouts." } },
			{
				"n",
				"<F5>",
				actions.prev_conflict,
				{ desc = "In the merge-tool: jump to the previous conflict" },
			},
			{
				"n",
				"<F6>",
				actions.next_conflict,
				{ desc = "In the merge-tool: jump to the next conflict" },
			},
			{ "n", "00", actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{ "n", "11", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
			{ "n", "22", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
			{
				"n",
				"33",
				actions.conflict_choose("theirs"),
				{ desc = "Choose the THEIRS version of a conflict" },
			},
			{ "n", "<Leader>00", actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{ "n", "<Leader>11", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
			{ "n", "<Leader>22", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
			{
				"n",
				"<Leader>33",
				actions.conflict_choose("theirs"),
				{ desc = "Choose the THEIRS version of a conflict" },
			},
			{ "n", "dx", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
		},
		diff1 = {
			-- Mappings in single window diff layouts
			{ "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
		},
		diff2 = {
			-- Mappings in 2-way diff layouts
			{ "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
		},
		diff3 = {
			-- Mappings in 3-way diff layouts
			{ "n", "00",         actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{
				{ "n",                                                            "x" },
				"11",
				actions.diffget("base"),
				{ desc = "Obtain the diff hunk from the BASE version of the file" },
			},
			{
				{ "n",                                                            "x" },
				"22",
				actions.diffget("ours"),
				{ desc = "Obtain the diff hunk from the OURS version of the file" },
			},
			{
				{ "n",                                                              "x" },
				"33",
				actions.diffget("theirs"),
				{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
			},
			{ "n", "<Leader>00", actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{ "n", "<Leader>11", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
			{ "n", "<Leader>22", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
			{
				"n",
				"<Leader>33",
				actions.conflict_choose("theirs"),
				{ desc = "Choose the THEIRS version of a conflict" },
			},
			{ "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
		},
		diff4 = {
			-- Mappings in 4-way diff layouts
			{ "n", "00",         actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{
				{ "n",                                                            "x" },
				"11",
				actions.diffget("base"),
				{ desc = "Obtain the diff hunk from the BASE version of the file" },
			},
			{
				{ "n",                                                            "x" },
				"22",
				actions.diffget("ours"),
				{ desc = "Obtain the diff hunk from the OURS version of the file" },
			},
			{
				{ "n",                                                              "x" },
				"33",
				actions.diffget("theirs"),
				{ desc = "Obtain the diff hunk from the THEIRS version of the file" },
			},
			{ "n", "<Leader>00", actions.conflict_choose("all"),  { desc = "Choose all the versions of a conflict" } },
			{ "n", "<Leader>11", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
			{ "n", "<Leader>22", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
			{
				"n",
				"<Leader>33",
				actions.conflict_choose("theirs"),
				{ desc = "Choose the THEIRS version of a conflict" },
			},
			{ "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
		},
		file_panel = {
			["o"] = function()
				actions.goto_file_edit()
				vim.cmd("tabclose #")
			end,
			{ "n", "j",      actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{ "n", "<down>", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
			{
				"n",
				"k",
				actions.prev_entry,
				{ desc = "Bring the cursor to the previous file entry." },
			},
			{
				"n",
				"<up>",
				actions.prev_entry,
				{ desc = "Bring the cursor to the previous file entry." },
			},
			{ "n", "<cr>",          actions.select_entry, { desc = "Open the diff for the selected entry." } },
			{ "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
			{
				"n",
				"-",
				actions.toggle_stage_entry,
				{ desc = "Stage / unstage the selected entry." },
			},
			{ "n", "S", actions.stage_all,   { desc = "Stage all entries." } },
			{ "n", "U", actions.unstage_all, { desc = "Unstage all entries." } },
			{
				"n",
				"X",
				actions.restore_entry,
				{ desc = "Restore entry to the state on the left side." },
			},
			{
				"n",
				"L",
				actions.open_commit_log,
				{ desc = "Open the commit log panel." },
			},
			{
				"n",
				"<tab>",
				actions.select_next_entry,
				{ desc = "Open the diff for the next file" },
			},
			{
				"n",
				"<s-tab>",
				actions.select_prev_entry,
				{ desc = "Open the diff for the previous file" },
			},
			{
				"n",
				"i",
				actions.listing_style,
				{ desc = "Toggle between 'list' and 'tree' views" },
			},
			{
				"n",
				"f",
				actions.toggle_flatten_dirs,
				{ desc = "Flatten empty subdirectories in tree listing style." },
			},
			{
				"n",
				"R",
				actions.refresh_files,
				{ desc = "Update stats and entries in the file list." },
			},
			{ "n", "<Leader>e", actions.focus_files,                       { desc = "Bring focus to the file panel" } },
			{ "n", "<Leader>b", actions.toggle_files,                      { desc = "Toggle the file panel" } },
			{ "n", "g<C-x>",    actions.cycle_layout,                      { desc = "Cycle available layouts" } },
			{ "n", "<F5>",      actions.prev_conflict,                     { desc = "Go to the previous conflict" } },
			{ "n", "<F6>",      actions.next_conflict,                     { desc = "Go to the next conflict" } },
			{ "n", "cc",        ":tabclose<Cr>:Git commit<Cr>",            { desc = "Commit the staged changes" } },
			{ "n", "rr",        ":tabclose<Cr>:Git rebase --continue<Cr>", { desc = "Continue the rebase process" } },
			{
				"n",
				"ca",
				":tabclose<Cr>:Git commit --amend<Cr>",
				{ desc = "Amend the last commit and edit the message." },
			},
			{ "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
		},
		file_history_panel = {
			["o"] = function()
				actions.goto_file_edit()
				vim.cmd("tabclose #")
			end,
			{ "n", "g!", actions.options,         { desc = "Open the option panel" } },
			{
				"n",
				"y",
				actions.copy_hash,
				{ desc = "Copy the commit hash of the entry under the cursor" },
			},
			{ "n", "L",  actions.open_commit_log, { desc = "Show commit details" } },
			{ "n", "zR", actions.open_all_folds,  { desc = "Expand all folds" } },
			{ "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
			{
				"n",
				"j",
				actions.next_entry,
				{ desc = "Bring the cursor to the next file entry" },
			},
			{
				"n",
				"<down>",
				actions.next_entry,
				{ desc = "Bring the cursor to the next file entry" },
			},
			{
				"n",
				"k",
				actions.prev_entry,
				{ desc = "Bring the cursor to the previous file entry." },
			},
			{
				"n",
				"<up>",
				actions.prev_entry,
				{ desc = "Bring the cursor to the previous file entry." },
			},
			{
				"n",
				"<cr>",
				actions.select_entry,
				{ desc = "Open the diff for the selected entry." },
			},
			{ "n", "<tab>",     actions.select_next_entry,          { desc = "Open the diff for the next file" } },
			{
				"n",
				"<s-tab>",
				actions.select_prev_entry,
				{ desc = "Open the diff for the previous file" },
			},
			{ "n", "<Leader>e", actions.focus_files,                { desc = "Bring focus to the file panel" } },
			{ "n", "<Leader>b", actions.toggle_files,               { desc = "Toggle the file panel" } },
			{ "n", "g<C-x>",    actions.cycle_layout,               { desc = "Cycle available layouts" } },
			{ "n", "g?",        actions.help("file_history_panel"), { desc = "Open the help panel" } },
		},
		option_panel = {
			{ "n", "<tab>", actions.select_entry,         { desc = "Change the current option" } },
			{ "n", "q",     actions.close,                { desc = "Close the panel" } },
			{ "n", "R",     actions.refresh_files,        { desc = "Update stats and entries in the file list." } },
			{ "n", "g?",    actions.help("option_panel"), { desc = "Open the help panel" } },
		},
		help_panel = {
			{ "n", "q",     actions.close, { desc = "Close help menu" } },
			{ "n", "<esc>", actions.close, { desc = "Close help menu" } },
		},
	},
})

local opts = { noremap = true }
local s_opts = { noremap = true, silent = true }

vim.keymap.set("n", "<F9>", ":DiffviewOpen<Cr>", opts)
vim.keymap.set("n", "<Leader><F10>", ":DiffviewOpen<Space>", opts)
vim.keymap.set("n", "<F12>", ":DiffviewFileHistory<Cr>", s_opts)
vim.keymap.set("n", "<Leader><F12>", ":DiffviewFileHistory %<Cr>", s_opts)
vim.keymap.set("v", "<F12>", ":'<,'>DiffviewFileHistory<Cr>", s_opts)

-- set the removed lines as /
vim.opt.fillchars:append({ diff = "╾" })
