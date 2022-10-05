vim.bo.formatprg = "python3 -m json.tool"

vim.lsp.start({
    name = "vscode-json-language-server",
    cmd = { "vscode-json-language-server", "--stdio" },
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
})
