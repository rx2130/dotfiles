local M = {}

local function on_attach(client)
	vim.api.nvim_buf_set_option(0, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(0, "tagfunc", "v:lua.vim.lsp.tagfunc")
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
	vim.keymap.set("n", "gD", function()
		require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "gr", function()
		require("fzf-lua").lsp_references({ jump_to_single_result = true })
	end, opts)
	vim.keymap.set("n", "gs", require("fzf-lua").lsp_document_symbols, opts)
	vim.keymap.set("n", "gS", require("fzf-lua").lsp_live_workspace_symbols, opts)
	vim.keymap.set("n", "cr", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>a", require("fzf-lua").lsp_code_actions, opts)
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
	local servers = { "pyright", "gopls", "tsserver", "texlab", "clangd", "rust_analyzer", "yamlls" }
	for _, lsp in ipairs(servers) do
		nvim_lsp[lsp].setup({ on_attach = on_attach })
	end

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = false,
		signs = false,
		update_in_insert = false,
	})

	nvim_lsp.sumneko_lua.setup({
		on_attach = on_attach,
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
end

local function jdtls_on_attach(client)
	on_attach(client)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.setup").add_commands()

	vim.keymap.set("n", "<leader>dt", require("jdtls").test_nearest_method, { buffer = true })
	vim.keymap.set("n", "<leader>dT", require("jdtls").test_class, { buffer = true })
end

function M.start_jdt()
	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:find("fugitive://") then
		return
	end
	if bufname:find("[java] ") then
		return
	end

	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	local home = os.getenv("HOME")
	local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

	local ws_folders_jdtls = {}
	if root_dir then
		local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r")
		if file then
			for line in file:lines() do
				table.insert(ws_folders_jdtls, string.format("file://%s", line))
			end
			file:close()
		end
	end

	local jar_patterns = {
		"/Developer/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		"/Developer/vscode-java-decompiler/server/*.jar",
		"/Developer/vscode-java-test/server/*.jar",
	}
	local bundles = {}
	for _, jar_pattern in ipairs(jar_patterns) do
		for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
			if bundle ~= "" then
				table.insert(bundles, bundle)
			end
		end
	end

	local system_name = vim.fn.has("mac") == 1 and "mac" or "linux"
	local config = {
		on_attach = jdtls_on_attach,
		cmd = {
			"java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xms1g",
			"-javaagent:" .. home .. "/Developer/lombok.jar",
			"-jar",
			vim.fn.glob(home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
			"-configuration",
			home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. system_name,
			"-data",
			eclipse_workspace,
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
		},
		root_dir = root_dir,
		init_options = {
			bundles = bundles,
			workspaceFolders = ws_folders_jdtls,
		},
		settings = {
			java = {
				signatureHelp = { enabled = true },
				contentProvider = { preferred = "fernflower" },
			},
		},
	}

	require("jdtls").start_or_attach(config)
end

return M
