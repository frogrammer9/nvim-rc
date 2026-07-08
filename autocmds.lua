local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })

-- start lsp
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(ev)
	local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

	if client:supports_method('textDocument/completion') then
		vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
	end

	if not client:supports_method('textDocument/willSaveWaitUntil')
		and client:supports_method('textDocument/formatting') then
		vim.api.nvim_create_autocmd('BufWritePre', {
		group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
		buffer = ev.buf,
		callback = function()
			vim.lsp.buf.format({ bufnr = ev.buf, id = client.id, timeout_ms = 200 })
		end,
		})
	end
	end,
})


-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- diff on markdown and text files
vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		-- vim.opt_local.wrap = true
		-- vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- start treesitter
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("TreeSitterConfig", { clear = true }),
	callback = function(args)
		if vim.list_contains(config.get_installed(), vim.treesitter.language.get_lang(args.match)) then
			vim.treesitter.start(args.buf)
		end
	end,
})
