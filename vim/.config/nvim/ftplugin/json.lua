vim.bo.formatprg = "python3 -m json.tool"

vim.lsp.start({
	name = "vscode-json-language-server",
	cmd = { "vscode-json-language-server", "--stdio" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
