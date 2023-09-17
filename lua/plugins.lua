-- -- Uncomment out when first use
-- local fn = vim.fn
--
-- -- Automatically install packer
-- local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
--
-- if fn.empty(fn.glob(install_path)) > 0 then
-- 	PACKER_BOOTSTRAP = fn.system({
-- 		"git",
-- 		"clone",
-- 		"--depth",
-- 		"1",
-- 		"https://github.com/wbthomason/packer.nvim",
-- 		install_path,
-- 	})
-- 	print("Installing, wait a bit and reopen Neovim...")
-- 	vim.cmd([[packadd packer.nvim]])
-- end

-- Autoreload neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

return packer.startup(function(use)
	use("wbthomason/packer.nvim")

	-- Me Me Me
	use("kenken17/xopp.vim")

	-- Werkflow
	use("romainl/vim-qf")
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		-- need ripgrep for searching, sudo apt install ripgrep
	})
	use("nvim-telescope/telescope-ui-select.nvim")
	use("stevearc/dressing.nvim")
	use("dyng/ctrlsf.vim")
	use("mg979/vim-visual-multi")

	-- Color scheme
	-- Since using a symlink no need to install for now
	-- use("kenken17/simple.vim")

	-- IDE
	use("preservim/nerdtree")
	use("PhilRunninger/nerdtree-visual-selection")
	use("christoomey/vim-tmux-navigator")
	use("mhinz/vim-startify")
	use("vim-airline/vim-airline")
	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
	})

	-- Autocomplete
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lua")
	use("andersevenrud/cmp-tmux")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- Manage LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")

	-- Configue LSP
	use("neovim/nvim-lspconfig")

	-- Formatting and Linting
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { "nvim-lua/plenary.nvim" },
	})

	-- Editing
	use("numToStr/Comment.nvim")
	use({ "kylechui/nvim-surround", tag = "*" })
	use("Raimondi/delimitMate")
	use("tpope/vim-unimpaired")
	use("kamykn/spelunker.vim")
	use("vim-test/vim-test")
	use("benmills/vimux")
	use("tpope/vim-sleuth")
	use("godlygeek/tabular")
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- DB
	use("tpope/vim-dadbod")
	use("kristijanhusak/vim-dadbod-ui")
	use("kristijanhusak/vim-dadbod-completion")

	-- Source control
	use("tpope/vim-fugitive")
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	-- Tressitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("Wansmer/treesj")

	-- Testing ground
	use("nvim-treesitter/playground")
	-- use({ "norcalli/nvim-colorizer.lua", cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" } })

	-- -- Automatically set up your configuration after cloning packer.nvim
	-- -- Put this at the end after all plugins
	-- if PACKER_BOOTSTRAP then
	-- 	require("packer").sync()
	-- end
end)
