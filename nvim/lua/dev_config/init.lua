require("dev_config.remap")
require("dev_config.packer")
require("dev_config.set")

-- Treesitter configuration
require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
})
