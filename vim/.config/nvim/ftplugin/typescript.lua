vim.bo.formatprg = "prettier --parser typescript"

vim.lsp.start({
	name = "tsserver",
	cmd = { "typescript-language-server", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	init_options = {
		preferences = {
			includeInlayParameterNameHints = "all",
			includeInlayParameterNameHintsWhenArgumentMatchesName = false,
			includeInlayFunctionParameterTypeHints = true,
			includeInlayVariableTypeHints = true,
			includeInlayVariableTypeHintsWhenTypeMatchesName = false,
			includeInlayPropertyDeclarationTypeHints = true,
			includeInlayFunctionLikeReturnTypeHints = true,
			includeInlayEnumMemberValueHints = true,
		},
	},
})

local dap = require("dap")
local home = os.getenv("HOME")

dap.adapters["pwa-node"] = {
	type = "server",
	-- host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = { home .. "/Developer/js-debug/src/dapDebugServer.js", "${port}" },
	},
}

dap.configurations.typescript = {
	-- {
	-- 	type = "pwa-node",
	-- 	request = "launch",
	-- 	name = "Launch file",
	-- 	program = "${file}",
	-- 	cwd = "${workspaceFolder}",
	-- 	runtimeExecutable = "sls",
	-- 	-- sourceMaps = true,
	-- 	-- protocol = "inspector",
	-- 	-- console = "integratedTerminal",
	-- 	-- resolveSourceMapLocations = {
	-- 	-- 	"${workspaceFolder}/dist/**/*.js",
	-- 	-- 	"${workspaceFolder}/**",
	-- 	-- 	"!**/node_modules/**",
	-- 	-- },
	-- },
	-- {
	-- 	type = "pwa-node",
	-- 	request = "launch",
	-- 	name = "Launch file",
	-- 	program = "${file}",
	-- 	cwd = "${workspaceFolder}",
	-- 	runtimeExecutable = "ts-node",
	-- 	-- sourceMaps = true,
	-- 	-- protocol = "inspector",
	-- 	-- console = "integratedTerminal",
	-- 	-- resolveSourceMapLocations = {
	-- 	-- 	"${workspaceFolder}/dist/**/*.js",
	-- 	-- 	"${workspaceFolder}/**",
	-- 	-- 	"!**/node_modules/**",
	-- 	-- },
	-- },
	-- {
	-- 	type = "pwa-node",
	-- 	request = "launch",
	-- 	name = "Debug Jest Tests",
	-- 	-- trace = true, -- include debugger info
	-- 	runtimeExecutable = "node",
	-- 	runtimeArgs = {
	-- 		"./node_modules/jest/bin/jest.js",
	-- 		"--runInBand",
	-- 		"--testTimeout=10000000",
	-- 		"--testPathPattern=__tests__/async-task-generation/generator.test.ts",
	-- 	},
	-- 	rootPath = "${workspaceFolder}",
	-- 	cwd = "${workspaceFolder}",
	-- 	console = "integratedTerminal",
	-- 	internalConsoleOptions = "neverOpen",
	-- 	resolveSourceMapLocations = {
	-- 		"${workspaceFolder}/dist/**/*.js",
	-- 		"${workspaceFolder}/**",
	-- 		"!**/node_modules/**",
	-- 	},
	-- },
	-- {
	-- 	type = "pwa-node",
	-- 	request = "attach",
	-- 	name = "Debug (Attach) - Remote",
	-- 	hostName = "127.0.0.1",
	-- 	port = 3006,
	-- },
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach to process",
		pid = function ()
		  require("dap.utils").pick_process({filter = "node --inspect"})
		end,
		args = {},
		cwd = "${workspaceFolder}",
		runtimeExecutable = "ts-node",
	},
}
