local M = {}
local api = vim.api

function M.setup()
	local parts = {
		"%<",

		[[%{luaeval("require'me.statusline'.file_or_lsp_status()")}]],

		"%m%r%=",

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

function M.file_or_lsp_status()
	local messages = vim.lsp.util.get_progress_messages()
	local mode = api.nvim_get_mode().mode
	if mode ~= "n" or vim.tbl_isempty(messages) then
		return M.format_uri(vim.uri_from_bufnr(0))
	end
	local percentage
	local result = {}
	for _, msg in pairs(messages) do
		if msg.message then
			table.insert(result, msg.title .. ": " .. msg.message)
		else
			table.insert(result, msg.title)
		end
		if msg.percentage then
			percentage = math.max(percentage or 0, msg.percentage)
		end
	end
	if percentage then
		return string.format("%03d%%: %s", percentage, table.concat(result, ", "))
	else
		return table.concat(result, ", ")
	end
end

function M.format_uri(uri)
	if vim.startswith(uri, "jdt://") then
		local package = uri:match("contents/[%a%d._-]+/([%a%d._-]+)") or ""
		local class = uri:match("contents/[%a%d._-]+/[%a%d._-]+/([%a%d$]+).class") or ""
		return string.format("%s::%s", package, class)
	else
		return vim.fn.fnamemodify(vim.uri_to_fname(uri), ":.")
	end
end

return M
