vim.bo.formatprg = "python3 -m json.tool"

if vim.fn.executable("vscode-json-language-server") == 0 then
	return
end

vim.lsp.start({
	name = "vscode-json-language-server",
	cmd = { "vscode-json-language-server", "--stdio" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
