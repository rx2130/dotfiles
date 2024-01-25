vim.bo.formatprg = "prettier --parser vue"

if vim.fn.executable("vls") == 0 then
	return
end

vim.lsp.start({
	name = "vuels",
	cmd = { "vls" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json", "vue.config.js" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
