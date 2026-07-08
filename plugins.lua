vim.pack.add({
	{ src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://www.github.com/nvim-tree/nvim-tree.lua",
	"https://www.github.com/neovim/nvim-lspconfig",
	-- "https://github.com/L3MON4D3/LuaSnip",
	-- "https://github.com/obsidian-nvim/obsidian.nvim",
})

-- ======================================== 
--				   Config
-- ======================================== 

require("nvim-tree").setup({
	view = { width = 35, },
	filters = { dotfiles = false, },
	renderer = { group_empty = true, },
})

require("fzf-lua").setup({})

require("mini.pairs").setup({})
require("mini.surround").setup({})
require("mini.icons").setup({})
require("mini.statusline").setup({})
