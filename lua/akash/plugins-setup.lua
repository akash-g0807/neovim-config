-- auto install packer if not installed
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
	return
end

-- add list of plugins to install
return packer.startup(function(use)
	-- packer can manage itself
	use("wbthomason/packer.nvim")

	use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

	-- use("bluz71/vim-nightfly-guicolors") -- preferred colorscheme

	-- use("fneu/breezy")
	--material dark theme
	-- use("marko-cerovac/material.nvim")
	-- vim.g.material_style = "darker"

	-- Catppuccin theme
	use({ "catppuccin/nvim", as = "catppuccin" })

	use("christoomey/vim-tmux-navigator") -- tmux & split window navigation

	use("szw/vim-maximizer") -- maximizes and restores current window

	-- essential plugins
	use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)
	use("inkarkat/vim-ReplaceWithRegister") -- replace with register contents using motion (gr + motion)

	-- commenting with gc
	use("numToStr/Comment.nvim")

	-- file explorer
	use("nvim-tree/nvim-tree.lua")

	-- vs-code like icons
	use("nvim-tree/nvim-web-devicons")

	-- statusline
	use("nvim-lualine/lualine.nvim")

	-- fuzzy finding w/ telescope
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder

	-- autocompletion
	use("hrsh7th/nvim-cmp") -- completion plugin
	use("hrsh7th/cmp-buffer") -- source for text in buffer
	use("hrsh7th/cmp-path") -- source for file system paths

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	-- use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- Installation
	-- use({ "L3MON4D3/LuaSnip" })
	use({ "saadparwaiz1/cmp_luasnip" })

	-- telescope luasnip
	use({
		"benfowler/telescope-luasnip.nvim",
		module = "telescope._extensions.luasnip", -- if you wish to lazy-load
	})

	-- managing & installing lsp servers, linters & formatters
	use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
	use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig

	-- configuring lsp servers
	use("neovim/nvim-lspconfig") -- easily configure language servers
	use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
	use({
		"nvimdev/lspsaga.nvim",
		branch = "main",
		requires = {
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	}) -- enhanced lsp uis
	use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
	use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

	-- formatting & linting
	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- treesitter configuration
	use({
		"nvim-treesitter/nvim-treesitter",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- git integration
	use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

	-- latex
	use("lervag/vimtex")
	use({ "kdheepak/cmp-latex-symbols" })
	use({ "jbyuki/nabla.nvim" }) -- show symbols in editor

	-- PlatformIO
	use("normen/vim-pio")

	-- alpha.nvim
	use({
		"goolord/alpha-nvim",
		config = function()
			require("alpha").setup(require("alpha.themes.dashboard").config)
		end,
	})

	-- session manager
	use("Shatur/neovim-session-manager")

	-- discord rich prescence
	use("andweeb/presence.nvim")

	-- lazy git
	-- nvim v0.7.2
	use({
		"kdheepak/lazygit.nvim",
		-- optional for floating window border decoration
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

	-- oil nvim
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})
	-- image.nvim
	use("3rd/image.nvim")

	-- official rust tool, used for autoformatting
	use("rust-lang/rust.vim")

	-- rust LSP
	use("simrat39/rust-tools.nvim")

	-- Debug Adapter Protocol
	use("mfussenegger/nvim-dap")

	-- UI for DAP
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- Manage DAP in Mason
	use("jay-babu/mason-nvim-dap.nvim")

	-- multi line cursor editing
	use("mg979/vim-visual-multi")

	-- neorg
	use({
		"nvim-neorg/neorg",
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/notes",
								my_work_notes = "~/work/notes",
							},
							default_workspace = "notes",
						},
					},
				},
			})
		end,
		run = ":Neorg sync-parsers",
		requires = "nvim-lua/plenary.nvim",
	})

	-- Copilot
	use("github/copilot.vim")

	-- snippets
	use("honza/vim-snippets")

	-- ultisnips
	use("SirVer/ultisnips")

	-- cmp nvim ultisnips

	use("quangnguyen30192/cmp-nvim-ultisnips")

	if packer_bootstrap then
		require("packer").sync()
	end
end)
