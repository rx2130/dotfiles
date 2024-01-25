vim.bo.formatprg = "prettier --parser html"

if vim.fn.executable("vscode-html-language-server") == 0 then
	return
end

vim.lsp.start({
	name = "vscode-html-language-server",
	cmd = { "vscode-html-language-server", "--stdio" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
