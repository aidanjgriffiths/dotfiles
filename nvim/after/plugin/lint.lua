require("lint").linters_by_ft = {
    python = { "pylint", "ruff" },
    markdown = { "markdownlint" },
    lua = { "luacheck" },
    yaml = { "ansible-lint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
