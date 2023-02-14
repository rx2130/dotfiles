vim.bo.makeprg = "tectonic -X compile % --synctex --keep-logs --keep-intermediates"

vim.lsp.start({
	name = "texlab",
	cmd = { "texlab" },
	-- cmd = {
	-- 	"/Users/xuerx/Developer/texlab/target/debug/texlab",
	-- 	"-vvvv",
	-- 	"--log-file",
	-- 	"/Users/xuerx/Documents/resume/texlab.log",
	-- },
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	settings = {
		build = {
			executable = "tectonic",
			args = {
				"-X",
				"compile",
				"%f",
				"--synctex",
				"--keep-logs",
				"--keep-intermediates",
			},
			onSave = true,
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
	local texlab_client = vim.lsp.get_active_clients({ bufnr = bufnr, name = "texlab" })[1]
	local params = {
		textDocument = { uri = vim.uri_from_bufnr(bufnr) },
	}
	if texlab_client then
		texlab_client.request("textDocument/build", params, function(err, result)
			if err then
				error(tostring(err))
			end
			print("Build " .. texlab_build_status[result.status])
		end, bufnr)
	else
		print("method textDocument/build is not supported by any servers active on the current buffer")
	end
end

vim.api.nvim_buf_create_user_command(0, "TexlabBuild", buf_build, {})
