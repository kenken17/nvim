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
	use("kenken17/simple.vim")

	-- IDE
	use("preservim/nerdtree")
	use("christoomey/vim-tmux-navigator")
	use("mhinz/vim-startify")
	use("vim-airline/vim-airline")

	-- Autocomplete
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-nvim-lua")
	use("L3MON4D3/LuaSnip")
	use("andersevenrud/cmp-tmux")

	-- Snippets
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("neovim/nvim-lspconfig")
	use("jose-elias-alvarez/null-ls.nvim")

	-- Editing
	use("numToStr/Comment.nvim")
	use({ "kylechui/nvim-surround", tag = "*" })
	use("Raimondi/delimitMate")
	use("tpope/vim-unimpaired")
	use("kamykn/spelunker.vim")
	use("vim-test/vim-test")
	use("benmills/vimux")
	use("tpope/vim-sleuth")

	-- Source control
	use("tpope/vim-fugitive")
	use("cohama/agit.vim")
	use("lambdalisue/gina.vim")

	-- Tressitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- Testing ground
	use("nvim-treesitter/playground")
	use({ "norcalli/nvim-colorizer.lua", cmd = { "ColorizerToggle", "ColorizerAttachToBuffer" } })

	-- -- Automatically set up your configuration after cloning packer.nvim
	-- -- Put this at the end after all plugins
	-- if PACKER_BOOTSTRAP then
	-- 	require("packer").sync()
	-- end
end)
