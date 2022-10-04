vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local opts = { buffer = true }

        vim.keymap.set("n", "gd", function()
            require("fzf-lua").lsp_definitions({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "<c-]>", function()
            require("fzf-lua").lsp_declarations({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gi", function()
            require("fzf-lua").lsp_implementations({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("i", "<c-l>", vim.lsp.buf.signature_help, opts)
        vim.keymap.set("n", "gy", function()
            require("fzf-lua").lsp_typedefs({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "gr", function()
            require("fzf-lua").lsp_references({ jump_to_single_result = true })
        end, opts)
        vim.keymap.set("n", "gs", require("fzf-lua").lsp_document_symbols, opts)
        vim.keymap.set("n", "gS", require("fzf-lua").lsp_live_workspace_symbols, opts)
        vim.keymap.set("n", "cr", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>=", function()
            vim.lsp.buf.format({ async = true })
        end, opts)

        -- highlight current var under cursor
        if client.server_capabilities.documentHighlightProvider then
            local highlight_group = vim.api.nvim_create_augroup("document_highlight", { clear = true })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = 0,
                callback = vim.lsp.buf.document_highlight,
                group = highlight_group,
            })
            vim.api.nvim_create_autocmd("CursorMoved", {
                buffer = 0,
                callback = vim.lsp.buf.clear_references,
                group = highlight_group,
            })
        end
    end,
})

vim.diagnostic.config({
    underline = true,
    virtual_text = false,
    signs = false,
    update_in_insert = false,
})
