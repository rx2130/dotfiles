if vim.fn.executable("bash-language-server") == 0 then
	return
end

vim.lsp.start({
	name = "bash-language-server",
	cmd = { "bash-language-server", "start" },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
