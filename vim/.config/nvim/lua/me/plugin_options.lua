-- treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	-- indent = {
	-- 	enable = true,
	-- },
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				[">p"] = "@parameter.inner",
			},
			swap_previous = {
				["<p"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
	},
})

-- completion
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
	},
	sources = {
		{ name = "nvim_lua" },
		{ name = "luasnip" },
		{ name = "nvim_lsp" },
		{ name = "path" },
		{
			name = "buffer",
			keyword_length = 3,
			-- option = {
			-- 	get_bufnrs = function()
			-- 		local bufs = {}
			-- 		for _, win in ipairs(vim.api.nvim_list_wins()) do
			-- 			bufs[vim.api.nvim_win_get_buf(win)] = true
			-- 		end
			-- 		return vim.tbl_keys(bufs)
			-- 	end,
			-- },
		},
	},
})

-- fzf-lua
local function fugutive_open(selected, opts)
	local sha = selected[1]:match("[^ ]+")
	local uri = vim.fn.FugitiveFind(sha)
	if opts == 1 then
		vim.cmd("split " .. uri)
	elseif opts == 2 then
		vim.cmd("vsplit " .. uri)
	elseif opts == 3 then
		vim.cmd("tab split " .. uri)
	else
		vim.cmd("e " .. uri)
	end
end
local fugutive_actions = {
	["default"] = function(selected)
		fugutive_open(selected)
	end,
	["ctrl-s"] = function(selected)
		fugutive_open(selected, 1)
	end,
	["ctrl-v"] = function(selected)
		fugutive_open(selected, 2)
	end,
	["ctrl-t"] = function(selected)
		fugutive_open(selected, 3)
	end,
}
require("fzf-lua").setup({
	keymap = {
		builtin = {
			["/"] = "toggle-preview",
			["?"] = "toggle-fullscreen",
		},
		fzf = {
			["alt-a"] = "toggle-all",
		},
	},
	grep = {
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden -g '!{.git,node_modules}/'",
	},
	git = {
		commits = {
			actions = fugutive_actions,
			fzf_opts = {
				["--no-sort"] = "",
			},
		},
		bcommits = {
			actions = fugutive_actions,
			fzf_opts = {
				["--no-sort"] = "",
			},
		},
	},
	helptags = { previewer = { _ctor = false } },
	manpages = { previewer = { _ctor = false } },
})
fzf_cwd = function()
	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	if root_dir then
		return root_dir .. "/src/"
	end
end

-- Return the first index with the given value (or nil if not found).
local function indexOf(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return i
		end
	end
	return nil
end
-- https://github.com/neovim/neovim/blob/master/runtime/lua/vim/ui.lua
vim.ui.select = function(items, opts, on_choice)
	vim.validate({
		items = { items, "table", false },
		on_choice = { on_choice, "function", false },
	})
	opts = opts or {}
	local choices = {}
	local format_item = opts.format_item or tostring
	for i, item in pairs(items) do
		table.insert(choices, string.format("%d: %s", i, format_item(item)))
	end
	coroutine.wrap(function()
		local selected = require("fzf-lua").fzf({
			prompt = opts.prompt or "Code Actions>",
		}, choices)
		if selected then
			local choice = indexOf(choices, selected[1])
			on_choice(items[choice], choice)
		end
	end)()
end

-- nvim-tree
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_special_files = {}
vim.g.nvim_tree_show_icons = {}
local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup({
	width = 40,
	auto_close = true,
	update_focused_file = {
		enable = true,
	},
	filters = {
		custom = { ".git" },
	},
	view = {
		mappings = {
			list = {
				{ key = "<C-s>", cb = tree_cb("split") },
			},
		},
	},
})
