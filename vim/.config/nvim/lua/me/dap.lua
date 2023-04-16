local dap = require("dap")
local fzf = require("fzf-lua")
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
	dap.repl.toggle({ height = 12 })
end)
vim.keymap.set("n", "<leader>dl", dap.run_last)
vim.keymap.set("n", "<leader>dL", fzf.dap_breakpoints)
vim.keymap.set("n", "<leader>de", function()
	dap.set_exception_breakpoints("default")
end)
vim.keymap.set("n", "<leader>dE", function()
	dap.set_exception_breakpoints({})
end)
vim.keymap.set("n", "<leader>dC", dap.run_to_cursor)
vim.keymap.set("n", "<leader>df", fzf.dap_frames)
vim.keymap.set("n", "<leader>ds", fzf.dap_variables)
vim.keymap.set({ "n", "v" }, "<leader>K", dapWidgets.hover)
vim.keymap.set("n", "<leader>du", function()
	local widgets = dapWidgets
	widgets.sidebar(widgets.scopes).open()
	widgets.sidebar(widgets.frames).open()
end)

dap.listeners.after.event_initialized["me.dap"] = function()
	vim.keymap.set("n", "<up>", dap.restart_frame)
	vim.keymap.set("n", "<down>", dap.step_over)
	vim.keymap.set("n", "<left>", dap.step_out)
	vim.keymap.set("n", "<right>", dap.step_into)
end

local after_session = function()
	if not next(dap.sessions()) then
		pcall(vim.keymap.del, "n", "<up>")
		pcall(vim.keymap.del, "n", "<down>")
		pcall(vim.keymap.del, "n", "<left>")
		pcall(vim.keymap.del, "n", "<right>")
	end
end
dap.listeners.after.event_terminated["me.dap"] = after_session
dap.listeners.after.disconnect["me.dap"] = after_session
