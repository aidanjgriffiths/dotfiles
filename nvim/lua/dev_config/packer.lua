-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.3",
		-- or                            , branch = '0.1.x',
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({
		"rebelot/kanagawa.nvim",
		as = "kanagawa",
		config = function()
			vim.cmd("colorscheme kanagawa")
		end,
	})
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use("nvim-lua/plenary.nvim")
	use("ThePrimeagen/harpoon")
	use("mbbill/undotree")
	use("tpope/vim-fugitive")
	use("tpope/vim-surround")
	use("tpope/vim-commentary")
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
	--	use("christoomey/vim-tmux-navigator")
	use({
		"aserowy/tmux.nvim",
		config = function()
			return require("tmux").setup()
		end,
	})
	-- need to configure
	use("ThePrimeagen/git-worktree.nvim")
	use("vim-airline/vim-airline")
	use("vim-airline/vim-airline-themes")
	use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" })
end)
