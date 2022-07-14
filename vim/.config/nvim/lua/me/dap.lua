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

require("dap-python").setup()

require("dap-go").setup()

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

require("dap.ext.autocompl").attach()

local dapWidgets = require("dap.ui.widgets")
vim.keymap.set("n", "<leader>dc", dap.continue)
vim.keymap.set("n", "<leader>dd", dap.step_over)
vim.keymap.set("n", "<leader>di", dap.step_into)
vim.keymap.set("n", "<leader>do", dap.step_out)
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)
vim.keymap.set("n", "<leader>dp", function()
	dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)
vim.keymap.set("n", "<leader>dr", function()
	dap.repl.toggle({ height = 15 })
end)
vim.keymap.set("n", "<leader>dl", dap.run_last)
vim.keymap.set("n", "<leader>dL", dap.list_breakpoints)
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
vim.keymap.set("n", "<leader>df", function()
	dapWidgets.centered_float(dapWidgets.frames)
end)
vim.keymap.set("n", "<leader>ds", function()
	dapWidgets.centered_float(dapWidgets.scopes)
end)
vim.keymap.set("n", "<leader>K", dapWidgets.hover)
vim.keymap.set("v", "<leader>K", function()
	dapWidgets.hover(require("dap.utils").get_visual_selection_text)
end)
vim.keymap.set("n", "<leader>du", function()
	local widgets = dapWidgets
	widgets.sidebar(widgets.scopes).open()
	widgets.sidebar(widgets.frames).open()
end)
