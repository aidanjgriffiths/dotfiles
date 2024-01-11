-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	-- filesystem fuzzy finder, `<leader>pf` to use
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	-- nvim theme
	use({
		"rebelot/kanagawa.nvim",
		as = "kanagawa",
		config = function()
			vim.cmd("colorscheme kanagawa")
		end,
	})
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		-- config = function()
		-- 	vim.cmd("colorscheme catppuccin")
		-- end,
	})
	-- detailed syntax highlighting where there is no LSP
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	-- Pins file to temporary board with `<leader>a`, open board with `ctrl+e`
	use("ThePrimeagen/harpoon")
	-- Need to figure our how to use
	use("ThePrimeagen/git-worktree.nvim")
	-- track iterative changes to files which persists through different nvim sessions
	use("mbbill/undotree")
	use("tpope/vim-fugitive") -- git for vim, use :Git [options]
	-- surrounds text with `cs<current-surround><replacement-surround>`
	use("tpope/vim-surround")
	use("tpope/vim-commentary") -- comments using `gc[c]`
	-- enable formatting with Mason plugins or local environment
	-- the latter works best with current projects (01/11/23)
	use("mhartington/formatter.nvim")
	-- enable linting with Mason plugins
	use("mfussenegger/nvim-lint")
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v3.x",
		requires = {
			--- Manage LSP servers from neovim
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "L3MON4D3/LuaSnip" },
		},
	})
	-- Enables tmux pane movements consistant with nvim bindings, see remap.lua
	use({
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	})
	use({ "danielpieper/telescope-tmuxinator.nvim", requires = { "nvim-telescope/telescope.nvim" } })
	-- need to configure
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
	use({
		"stevearc/oil.nvim",
		config = function()
			require("oil").setup()
		end,
	})
	-- use("mfussenegger/nvim-jdtls")
	use("mfussenegger/nvim-dap")
end)
