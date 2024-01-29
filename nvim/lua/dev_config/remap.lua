vim.g.mapleader = " "

--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Moves highlighted text around with J and K
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- takes line below and appends to current line
vim.keymap.set("n", "J", "mzJ`z")
-- keeps cursor in the middle when half page jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- search terms stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland;
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- no idea why this is usefull overy a normal `d` command
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- makes it impossible to run Q
vim.keymap.set("n", "Q", "<nop>")

-- not really necessary due to format on write with formatter.nvim
vim.keymap.set("n", "<leader>f", ":Format<CR>")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>g", "<cmd>Git<CR>")
-- rename all patterns in file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- execute current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

vim.keymap.set("n", "vv", "<C-w>v", { silent = true })

-- Navigation through vim panes, works with tmux (~/.tmux.conf)
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { silent = true })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { silent = true })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { silent = true })
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { silent = true })
vim.keymap.set("n", "<F5>", ":buffers<CR>:buffer<Space>")
vim.keymap.set("n", "<F1>", [[:%s/\s\+$//e<cr>]])

-- toggle folding with space
vim.keymap.set({ "n", "v" }, "<leader>z", "za")

vim.api.nvim_create_autocmd({ "BufRead" }, {
    pattern = { "*.nc" },
    command = [[:! ncdump -h %]],
})

vim.keymap.set("n", "<leader>+", "5<C-w>+")
vim.keymap.set("n", "<leader>-", "5<C-w>-")
vim.keymap.set("n", "<leader>>", "5<C-w>>")
vim.keymap.set("n", "<leader><", "5<C-w><")
