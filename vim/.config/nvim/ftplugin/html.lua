vim.bo.formatprg = "prettier --parser html"

vim.lsp.start({
    name = "vscode-html-language-server",
    cmd = { "vscode-html-language-server", "--stdio" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
