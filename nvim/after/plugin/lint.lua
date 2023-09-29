require('lint').linters_by_ft = {
  python = {'pylint',}
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require('lint').try_lint()
    end,
})

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")

