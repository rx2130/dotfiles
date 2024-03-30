vim.bo.makeprg = "python3 %"

vim.bo.formatprg = "black --quiet -"

if vim.fn.executable("pyright-langserver") == 0 then
	return
end

vim.lsp.start({
	name = "pyright",
	cmd = { "pyright-langserver", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ "requirements.txt", "setup.py", "setup.cfg" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local dap = require("dap")
local dappy = require("dap-python")
if not dap.adapters.python then
	dappy.setup()
end
