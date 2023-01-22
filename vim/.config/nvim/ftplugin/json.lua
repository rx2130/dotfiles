vim.bo.formatprg = "python3 -m json.tool"

vim.lsp.start({
    name = "vscode-json-languageserver",
    cmd = { "vscode-json-languageserver", "--stdio" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
