local function map(mode, lhs, rhs, desc_str)
	vim.keymap.set(mode, lhs, rhs,
		{ silent = true, desc = desc_str })
end

local function mapexpr(mode, lhs, rhs, desc_str)
	vim.keymap.set(mode, lhs, rhs,
		{ replace_keycodes = true, silent = true, expr = true, desc = desc_str })
end

vim.g.mapleader = " "      -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- ===========================================================
--						   Buffers
-- ===========================================================

map("n", "<leader>bn", ":bnext<CR>", "Next buffer")
map("n", "<leader>bp", ":bprevious<CR>", "Previous buffer")

-- ===========================================================
--						  Navigation
-- ===========================================================

map("n", "ge", "$", "Go to end of line")
map("n", "gs", "^", "Go to start of line")

map("n", "==", "ggVG", "Select everything")
map({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", "Clear search highlights")

map("n", "<leader>ff", function() require("fzf-lua").files() end, "FZF Files")
map("n", "<leader>fg", function() require("fzf-lua").git_files() end, "FZF Files")
map("n", "<leader>gg", function() require("fzf-lua").live_grep() end, "FZF Live Grep")
map("n", "<leader>fb", function() require("fzf-lua").buffers() end, "FZF Buffers")
map("n", "<leader>fh", function() require("fzf-lua").help_tags() end, "FZF Help Tags")
map("n", "<leader>fd", function() require("fzf-lua").diagnostics_document() end, "FZF Diagnostics Document")
map("n", "<leader>fD", function() require("fzf-lua").diagnostics_workspace() end, "FZF Diagnostics Workspace")

map("n", "<leader>e",
	function() if vim.bo.filetype == "oil" then require("oil").close() else require("oil").open() end end, "Toggle Oil")

map("n", "gd", vim.lsp.buf.definition, "Go to definition")
map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
map("n", "gr", vim.lsp.buf.references, "Go to references")
map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
map("n", "K", vim.lsp.buf.hover, "LSP Hover")

-- ===========================================================
--					  Smart Line movement
-- ===========================================================

map("n", "<leader>d", "Vyp", "duplicate line")
map("v", "<leader>d", "y`>p", "duplicate lines")

map("n", "<A-j>", ":m .+1<CR>==", "Move line down")
map("n", "<A-k>", ":m .-2<CR>==", "Move line up")
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

map("v", "<", "<gv", "Indent left and reselect")
map("v", ">", ">gv", "Indent right and reselect")

map("n", "J", "mzJ`z", "Join lines and keep cursor position")

mapexpr("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, "Down (wrap-aware)")
mapexpr("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, "Up (wrap-aware)")

-- ===========================================================
--						Split motions
-- ===========================================================

map("n", "<leader>sv", ":vsplit<CR>", "Split window vertically")
map("n", "<leader>sh", ":split<CR>", "Split window horizontally")
map("n", "<C-Up>", ":resize +2<CR>", "Increase window height")
map("n", "<C-Down>", ":resize -2<CR>", "Decrease window height")
map("n", "<C-Left>", ":vertical resize -2<CR>", "Decrease window width")
map("n", "<C-Right>", ":vertical resize +2<CR>", "Increase window width")

-- ===========================================================
--						Text editing
-- ===========================================================

map("x", "p", '"_dP', "Paste without yanking")
map("v", "x", '"_d', "Delete without yanking")
map("n", "x", '"_x', "Delete without yanking")
map("v", '<C-c>', '"+y', "copy to clipboard")

map("v", "<C-s>", function()
	vim.cmd("normal! y")
	local txt = vim.fn.getreg('"')
	local cmd = string.format(":%%s/%s//g", txt)
	vim.cmd("normal! :")
	vim.fn.feedkeys(cmd, 'n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), 'n', true)
end)

map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", function() require("fzf-lua").lsp_code_actions() end, "Code actions")
map("n", "<leader>tr", vim.diagnostic.open_float, "Show diagnostic")

mapexpr("n", "cc", function() return require('vim._comment').operator() .. '_' end, "Toggle comment line")
mapexpr("v", "c", function() return require('vim._comment').operator() end, "Toggle comment selection")

mapexpr("i", "<Tab>", function() return vim.fn.pumvisible() == 1 and "<C-n>" or "<Tab>" end)
mapexpr("i", "<S-Tab>", function() return vim.fn.pumvisible() == 1 and "<C-p>" or "<S-Tab>" end)
mapexpr("i", "<CR>", function()
	local col, line = vim.fn.col("."), vim.fn.getline(".")
	local char_before, char_after = line:sub(col - 1, col - 1), line:sub(col, col)
	return (vim.fn.pumvisible() == 1) and "<C-y>"
		or (char_before == ">" and char_after == "<") and "<CR><Esc>O"
		---@diagnostic disable-next-line: undefined-field
		or _G.MiniPairs.cr()
end)

map({ "n", "i", "v", "t" }, "<F1>", "<Nop>")
