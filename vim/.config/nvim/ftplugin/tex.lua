vim.bo.makeprg = "tectonic -X compile % --synctex --keep-logs --keep-intermediates"

if vim.fn.executable("texlab") == 0 then
	return
end

vim.lsp.start({
	name = "texlab",
	cmd = { "texlab" },
	-- cmd = {
	-- 	"/opt/homebrew/bin/texlab",
	-- 	"-vvvv",
	-- 	"--log-file",
	-- 	"/Users/xuerx/Developer/resume/texlab.log",
	-- },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		texlab = {
			build = {
				executable = "tectonic",
				args = { "%f" },
				onSave = true,
			},
		},
	},
})

local texlab_build_status = vim.tbl_add_reverse_lookup({
	Success = 0,
	Error = 1,
	Failure = 2,
	Cancelled = 3,
})

local function buf_build()
	local bufnr = 0
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "texlab" })[1]
	local params = {
		textDocument = { uri = vim.uri_from_bufnr(bufnr) },
	}
	client.request("textDocument/build", params, function(err, result)
		if err then
			error(tostring(err))
		end
		vim.notify("Build " .. texlab_build_status[result.status])
	end, bufnr)
end

vim.api.nvim_buf_create_user_command(0, "TexlabBuild", buf_build, {})
