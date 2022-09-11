local api = vim.api

local M = {}
local winid = nil
local bufid = nil

local function launch_term()
	vim.cmd("enew")
	winid = vim.fn.win_getid()
	bufid = vim.api.nvim_win_get_buf(0)
	vim.fn.termopen(vim.fn.environ()["SHELL"])
end

local function open_term()
	vim.cmd("buffer " .. bufid)
end

local key = api.nvim_replace_termcodes("<C-^>", true, false, true)
local function hide_term()
	vim.api.nvim_feedkeys(key, "n", true)
end

function M.toggle()
	if winid and api.nvim_win_is_valid(winid) then
		hide_term()
	else
		if bufid and api.nvim_buf_is_valid(bufid) then
			open_term()
		else
			launch_term()
		end
	end
end

return M
