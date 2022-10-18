vim.bo.formatprg = "black --quiet -"

vim.lsp.start({
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    root_dir = vim.fs.dirname(vim.fs.find({ "requirements.txt", "setup.py", "setup.cfg" }, { upward = true })[1]),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

require("dap-python").setup()
