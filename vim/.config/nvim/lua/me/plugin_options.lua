-- treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
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
			opts = {
				get_bufnrs = function()
					local bufs = {}
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						bufs[vim.api.nvim_win_get_buf(win)] = true
					end
					return vim.tbl_keys(bufs)
				end,
			},
		},
	},
})

-- fzf-lua
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
	lsp = {
		async_or_timeout = 5000,
	},
	grep = {
		rg_opts = "--hidden --column --line-number --no-heading "
			.. "--color=always --smart-case -g '!{.git,node_modules}/*'",
	},
	git = {
		commits = {
			actions = {
				["default"] = function(selected)
					local sha = selected[1]:match("[^ ]+")
					local uri = vim.fn.FugitiveFind(sha)
					vim.cmd("vsplit " .. uri)
				end,
			},
		},
	},
	helptags = { previewer = { _ctor = false } },
})
fzf_cwd = function()
	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	if root_dir then
		return root_dir .. "/src/"
	end
end

-- nvim-tree
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_quit_on_open = 1
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
