local telescope = require("telescope")
telescope.setup({
	extensions = {
		tmuxinator = {
			select_action = "switch", -- | 'stop' | 'kill'
			stop_action = "stop", -- | 'kill'
			disable_icons = false,
		},
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>pt", function()
	telescope.extensions.tmuxinator.projects(require("telescope.themes").get_dropdown({}))
end)
