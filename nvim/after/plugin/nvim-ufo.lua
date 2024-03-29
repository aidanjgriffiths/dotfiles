vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- might need to change mapping in future
vim.keymap.set("n", "zK", function()
    local winid = require("ufo").peekFoldedLinesUnderCursor()
    if not winid then
        vim.lsp.buf.hover()
    end
end, { desc = "Peek fold" })

require("ufo").setup({
    provider_selctor = function(bufnr, filetype, buftype)
        return { "lsp", "indent" }
    end,
})
