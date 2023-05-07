vim.bo.errorformat = "%f:%l.%c-%[%^:]%#: %m,%f:%l:%c: %m"

vim.lsp.start({
	name = "gopls",
	cmd = { "gopls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "go.mod" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local dap = require("dap")

dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Launch file",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Launch file with arguments",
		request = "launch",
		program = "${file}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " +")
		end,
	},
}
