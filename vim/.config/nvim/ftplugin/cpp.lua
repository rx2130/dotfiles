vim.lsp.start({
	name = "clangd",
	cmd = { "clangd" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local dap = require("dap")

dap.adapters.lldb = {
	type = "executable",
    command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "lldb: Launch (integratedTerminal)",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
		runInTerminal = true,
	},
}
