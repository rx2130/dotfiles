if vim.fn.filereadable("./Cargo.toml") ~= 0 then
	vim.o.makeprg = "cargo build"
else
	vim.bo.makeprg = "rustc %"
end

vim.lsp.start({
    name = "rust-analyzer",
    cmd = { "rust-analyzer" },
    root_dir = vim.fs.dirname(vim.fs.find({ ".git", "Cargo.toml" }, { upward = true })[1]),
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})


local dap = require("dap")

dap.adapters.lldb = {
    type = "executable",
    command = "/home/linuxbrew/.linuxbrew/bin/lldb-vscode",
    name = "lldb",
}

dap.configurations.rust = {
    {
        name = "Launch (lldb via integrated terminal)",
        type = "lldb",
        request = "launch",
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
        args = {},
        runInTerminal = true,
    },
}
