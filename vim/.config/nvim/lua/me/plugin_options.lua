vim.keymap.set("n", "<leader>C", vim.diagnostic.setloclist)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

local utils = require("fzf-lua.utils")
local open = vim.fn.has("macunix") == 1 and "open" or "xdg-open"
vim.keymap.set({ "n", "v" }, "gx", function()
	local query = vim.fn.mode() == "n" and vim.fn.expand("<cWORD>") or utils.get_visual_selection()
	local url = string.match(query, "https?://[%w-_%.%?%.:/%+=&]+[^ >\"',;`]*")
	if url ~= nil then
		vim.cmd(('!%s "%s"'):format(open, url))
	else
		query = query:gsub(" ", "+")
		vim.cmd(('!%s "https://www.google.com/search?q=%s"'):format(open, query))
	end
end)

vim.keymap.set("n", "<leader>t", require("me.term").toggle)

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
local luasnip = require("luasnip")
local cmp = require("cmp")
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
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
	-- experimental = {
	-- 	ghost_text = true,
	-- },
})

-- nvim-autopairs
require("nvim-autopairs").setup({})

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
require("fzf-lua").register_ui_select()

fzf_cwd = function()
	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	if root_dir then
		return root_dir .. "/src/"
	end
end

-- nvim-tree
local tree_cb = require("nvim-tree.config").nvim_tree_callback
require("nvim-tree").setup({
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
	renderer = {
		group_empty = true,
		special_files = {},
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
			},
		},
	},
})
