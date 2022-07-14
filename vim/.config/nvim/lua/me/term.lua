local api = vim.api

local M = {}
local winid = nil
local bufid = nil

local function launch_term()
	vim.cmd("new")
	winid = vim.fn.win_getid()
	bufid = vim.api.nvim_win_get_buf(0)
	vim.fn.termopen(vim.fn.environ()["SHELL"])
end

local function open_term()
	vim.cmd("new")
	local tmpbuf = vim.api.nvim_win_get_buf(0)
	winid = vim.fn.win_getid()
	api.nvim_win_set_buf(winid, bufid)
	api.nvim_buf_delete(tmpbuf, { force = true })
end

local function hide_term()
	if api.nvim_win_is_valid(winid) then
		if #api.nvim_tabpage_list_wins(0) > 1 then
			api.nvim_win_hide(winid)
		end
	end
	winid = nil
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
