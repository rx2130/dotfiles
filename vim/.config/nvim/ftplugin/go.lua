vim.lsp.start({
    name = "gopls",
    cmd = { "gopls" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "go.mod" }, { upward = true })[1]),
    capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
})
