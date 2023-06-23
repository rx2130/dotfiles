local M = {}

function M.setup()
	local parts = {
		"%<",

		[[%{luaeval("require'me.statusline'.file_or_lsp_status()")}]],

		" %m%r%=",

		"%#warningmsg#",
		"%{&paste?'[paste] ':''}",
		"%*",

		"%#warningmsg#",
		"%{&ff!='unix'?'['.&ff.'] ':''}",
		"%*",

		"%#warningmsg#",
		"%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.'] ':''}",
		"%*",

		"%-14.(%l,%v%)",

		[[%{luaeval("require'me.statusline'.dap_status()")}]],

		[[%{luaeval("require'me.statusline'.diagnostic_status()")}]],
	}
	return table.concat(parts)
end

function M.diagnostic_status()
	local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
	if num_errors > 0 then
		return " 💀 " .. num_errors .. " "
	end
	local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
	if num_warnings > 0 then
		return " 💩" .. num_warnings .. " "
	end
	return ""
end

function M.dap_status()
	local status = require("dap").status()
	if status ~= "" then
		return status .. " | "
	end
	return ""
end

local function format_uri(uri)
	if vim.startswith(uri, "jdt://") then
		local package = uri:match("contents/[%a%d._-]+/([%a%d._-]+)") or ""
		local class = uri:match("contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class") or ""
		return string.format("%s::%s", package, class)
	else
		return vim.fn.fnamemodify(vim.uri_to_fname(uri), ":.")
	end
end

function M.file_or_lsp_status()
	local lsp_status = vim.lsp.status()
	local mode = vim.api.nvim_get_mode().mode
	if mode ~= "n" or lsp_status == "" then
		return format_uri(vim.uri_from_bufnr(vim.api.nvim_get_current_buf()))
	end
	return lsp_status
end

return M
