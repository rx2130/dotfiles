vim.bo.formatprg = "prettier --parser typescript"

vim.lsp.start({
    name = "tsserver",
    cmd = { "typescript-language-server", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "package.json" }, { upward = true })[1]),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
