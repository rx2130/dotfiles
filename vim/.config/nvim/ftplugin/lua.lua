vim.bo.formatprg = "stylua -"

if vim.fn.executable("lua-language-server") == 0 then
	return
end

vim.lsp.start({
	name = "lua-language-server",
	cmd = { "lua-language-server" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
	init_options = {
        hint = { enable = true },
	},
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
