vim.bo.makeprg = "tectonic %"

vim.lsp.start({
    name = "texlab",
    cmd = { "texlab" },
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
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
