local lsp = require("lsp-zero")

local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({ buffer = bufnr })
end)

-- install linters and fixers in project venvs
require("mason").setup({
	ensure_installed = { "shellcheck", "stylua" },
})

require("mason-lspconfig").setup({
	-- Replace the language servers listed here
	-- with the ones you want to install
	-- see fixer.lua and lint.lua for fixers and linters
	-- manually install "pylint"
	ensure_installed = { "pyright", "tsserver" },

	handlers = {
		lsp_zero.default_setup,
	},
})

-- Fix Undefined global 'vim'
local lua_opts = lsp_zero.nvim_lua_ls()
require("lspconfig").lua_ls.setup(lua_opts)

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
	["<C-y>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
})

lsp.set_preferences({
	suggest_lsp_servers = false,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gf", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "ga", function()
		vim.lsp.buf.declaration()
		vim.lsp.buf.clear_references()
	end, opts)
	-- doesn't add highlighted term to "n" and "N"
	-- 	vim.keymap.set("n", "ga", function()
	-- 		vim.lsp.buf.document_highlight()
	-- 		vim.lsp.buf.clear_references()
	-- 	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>vws", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>vca", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>vrr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>vrn", function()
		vim.lsp.buf.rename()
	end, opts)
	-- 	vim.keymap.set("i", "<C-h>", function()
	-- 		vim.lsp.buf.signature_help()
	-- 	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
