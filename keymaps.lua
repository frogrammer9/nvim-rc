local function map(mode, lhs, rhs, desc_str)
	vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc_str })
end

vim.g.mapleader = " " -- space for leader
vim.g.maplocalleader = " " -- space for localleader

-- ===========================================================
--						   Buffers
-- ===========================================================

map("x", "<leader>p", '"_dP', "Paste without yanking")
map({ "n", "v" }, "<leader>x", '"_d', "Delete without yanking")

map("n", "<leader>bn", ":bnext<CR>", "Next buffer")
map("n", "<leader>bp", ":bprevious<CR>", "Previous buffer")

-- ===========================================================
--						  Navigation
-- ===========================================================

map("n", "ge", "$", "Go to end of line")
map("n", "gs", "^", "Go to start of line")

map("n", "==", "ggVG", "Select everything")
map({"n", "i"}, "<esc>", "<cmd>noh<cr><esc>", "Clear search highlights")

map("n", "<leader>ff", require("telescope.builtin").find_files)
map("n", "<leader>gg", require("telescope.builtin").live_grep)
map("n", "<leader>fg", require("telescope.builtin").git_files)
-- map("n", "<leader>ft", ":TodoTelescope<CR>")	-- find todo
--
map("n", "<leader>e", function() require("nvim-tree.api").tree.toggle() end, "Toggle NvimTree")


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

vim.keymap.set("n", "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
vim.keymap.set("n", "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

map("n", "<leader>ff", function() require("fzf-lua").files() end, "FZF Files")
map("n", "<leader>fg", function() require("fzf-lua").live_grep() end, "FZF Live Grep")
map("n", "<leader>fb", function() require("fzf-lua").buffers() end, "FZF Buffers")
map("n", "<leader>fh", function() require("fzf-lua").help_tags() end, "FZF Help Tags")
map("n", "<leader>fx", function() require("fzf-lua").diagnostics_document() end, "FZF Diagnostics Document")
map("n", "<leader>fX", function() require("fzf-lua").diagnostics_workspace() end, "FZF Diagnostics Workspace")

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

map("v", "<C-s>", function()
	vim.cmd("normal! y")
	local txt = vim.fn.getreg('"')
	local cmd = string.format(":%%s/%s//g", txt)
	vim.cmd("normal! :")
	vim.fn.feedkeys(cmd, 'n')
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Left><Left>", true, false, true), 'n', true)
end)


map("n", "<leader>td", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end, "Toggle diagnostics")
