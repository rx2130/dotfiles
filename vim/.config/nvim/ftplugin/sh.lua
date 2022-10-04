vim.lsp.start({
    name = "bash-language-server",
    cmd = { "bash-language-server", "start" },
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
})

