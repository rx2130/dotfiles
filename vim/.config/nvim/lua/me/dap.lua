local dap = require("dap")

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Debug (Attach) - Remote",
		hostName = "127.0.0.1",
		port = 5005,
	},
}

require('dap-python').setup('python3')

dap.adapters.lldb = {
	type = "executable",
	command = "/home/linuxbrew/.linuxbrew/bin/lldb-vscode",
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch (lldb via integrated terminal)",
		type = "lldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		args = {},
		runInTerminal = true,
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

require('dap.ext.autocompl').attach()
