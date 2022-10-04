vim.lsp.start({
    name = "texlab",
    cmd = { "texlab" },
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    settings = {
        texlab = {
            build = {
                executable = "tectonic",
                args = { "-X", "compile", "%f" },
                onSave = true,
            },
        },
    },
})
