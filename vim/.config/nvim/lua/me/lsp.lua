local M = {}

function M.on_attach(client)
	if not pcall(vim.api.nvim_buf_get_option, 0, "formatprg") then
		vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	end

	local opts = { buffer = true }

	vim.keymap.set("n", "gd", function()
		require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "<c-]>", function()
		require("fzf-lua").lsp_declarations({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", function()
		require("fzf-lua").lsp_implementations({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("i", "<c-l>", vim.lsp.buf.signature_help, opts)
	vim.keymap.set("n", "gy", function()
		require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "gr", function()
		require("fzf-lua").lsp_references({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "gs", require("fzf-lua").lsp_document_symbols, opts)
	vim.keymap.set("n", "gS", require("fzf-lua").lsp_live_workspace_symbols, opts)
	vim.keymap.set("n", "cr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>=", vim.lsp.buf.formatting, opts)

	-- highlight current var under cursor
	if client.server_capabilities.documentHighlightProvider then
		local highlight_group = vim.api.nvim_create_augroup("document_highlight", { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = 0,
			callback = vim.lsp.buf.document_highlight,
			group = highlight_group,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			buffer = 0,
			callback = vim.lsp.buf.clear_references,
			group = highlight_group,
		})
	end
end

do
	local nvim_lsp = require("lspconfig")
	local servers = { "pyright", "gopls", "tsserver", "clangd", "rust_analyzer", "yamlls", "bashls" }
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup({ on_attach = M.on_attach })
	end

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false,
		signs = false,
		update_in_insert = false,
	})

	nvim_lsp.sumneko_lua.setup({
		on_attach = M.on_attach,
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
				},
				diagnostics = {
					globals = { "vim", "hs" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
				},
				telemetry = {
					enable = false,
				},
			},
		},
	})

	nvim_lsp.texlab.setup({
		on_attach = M.on_attach,
		settings = {
			texlab = {
				build = {
					executable = "tectonic",
					args = {
						"-X",
						"compile",
						"%f",
					},
					onSave = true,
				},
			},
		},
	})
end

return M
