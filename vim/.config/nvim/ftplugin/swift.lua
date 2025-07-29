if vim.fn.executable("sourcekit-lsp") == 0 then
	return
end

vim.lsp.start({
	name = "sourcekit-lsp",
	cmd = { "sourcekit-lsp" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git", "Package.swift" }, { upward = true })[1]),
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
