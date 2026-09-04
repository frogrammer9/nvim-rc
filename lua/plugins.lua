vim.pack.add({
	{ src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
	"https://www.github.com/ibhagwan/fzf-lua",
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://www.github.com/neovim/nvim-lspconfig",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/meanderingprogrammer/render-markdown.nvim",
	"https://github.com/windwp/nvim-ts-autotag",
})

-- ========================================
--				   Config
-- ========================================

require("gruvbox").setup()

require("fzf-lua").setup({
	ui_select = {},
	keymap = {
		fzf = {
			["tab"] = "down",
			["shift-tab"] = "up",
		},
	},
})

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = false,
	}
})

require("mini.pairs").setup()
require("mini.icons").setup()
require("render-markdown").setup()

local hipatterns = require('mini.hipatterns')
hipatterns.setup({
	highlighters = {
		fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
		hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
		todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
		note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
		hex_color = hipatterns.gen_highlighter.hex_color(),
	},
})

require('nvim-ts-autotag').setup()
