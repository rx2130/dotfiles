vim.bo.formatprg = "prettier --parser typescript"

vim.lsp.start({
	name = "tsserver",
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local dap = require("dap")

dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { "/Users/xuerx/Developer/vscode-js-debug/dist/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
		runtimeExecutable = "ts-node",
		sourceMaps = true,
		protocol = "inspector",
		-- console = "integratedTerminal",
		resolveSourceMapLocations = {
			"${workspaceFolder}/dist/**/*.js",
			"${workspaceFolder}/**",
			"!**/node_modules/**",
		},
	},
	{
		type = "pwa-node",
		request = "launch",
		name = "Debug Jest Tests",
		-- trace = true, -- include debugger info
		runtimeExecutable = "node",
		runtimeArgs = {
			"./node_modules/jest/bin/jest.js",
			"--runInBand",
		},
		rootPath = "${workspaceFolder}",
		cwd = "${workspaceFolder}",
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
		resolveSourceMapLocations = {
			"${workspaceFolder}/dist/**/*.js",
			"${workspaceFolder}/**",
			"!**/node_modules/**",
		},
	},
}
