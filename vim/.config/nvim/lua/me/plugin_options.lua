vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)

local utils = require("fzf-lua.utils")
local open = vim.fn.has("mac") == 1 and "open" or "xdg-open"
local char_to_hex = function(c)
	return string.format("%%%02X", string.byte(c))
end
vim.keymap.set({ "n", "v" }, "gx", function()
	local query = vim.fn.mode() == "n" and vim.fn.expand("<cWORD>") or utils.get_visual_selection()
	local url = query:match("https?://[%w%.%+%-%?_:/=&#]+")
	if url == nil then
		query = query:gsub("\n", " ")
		query = query:gsub("([^%w ])", char_to_hex)
		query = query:gsub(" ", "+")
		url = "https://www.google.com/search?q=" .. query
	end
	print(url)
	vim.fn.system(('%s "%s"'):format(open, url))
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
local fzf = require("fzf-lua")
fzf.setup({
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
fzf.register_ui_select()

local function fzf_cwd()
	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	if root_dir then
		return root_dir .. "/src/"
	end
end

vim.keymap.set("n", "<leader>f", function()
	fzf.files({ cwd = fzf_cwd() })
end)
vim.keymap.set("n", "<C-p>", function()
	local file_name = vim.fn.expand("%:t:r")
	fzf.files()
	vim.api.nvim_feedkeys(file_name, "n", true)
end)
vim.keymap.set("n", "<leader>op", function()
	fzf.files({ cwd = "~/.local/share/nvim/site/pack/plugins/start/" })
end)
vim.keymap.set("n", "<leader>od", function()
	fzf.files({ cwd = "~/dotfiles/" })
end)
vim.keymap.set("n", "<leader>F", fzf.git_status)
vim.keymap.set("n", "<leader>b", fzf.buffers)
vim.keymap.set("n", "<leader>H", fzf.oldfiles)
vim.keymap.set("n", "<leader>L", fzf.blines)
vim.keymap.set("n", "<leader>l", fzf.resume)
vim.keymap.set("n", "<leader>'", fzf.marks)
vim.keymap.set("n", "<leader>;", fzf.commands)
vim.keymap.set("n", "<leader>:", fzf.command_history)
vim.keymap.set("n", "<leader>S", fzf.filetypes)
vim.keymap.set("n", "<leader>h", fzf.help_tags)
vim.keymap.set("n", "<leader>m", fzf.man_pages)
vim.keymap.set("n", "<leader>M", fzf.keymaps)
vim.keymap.set("n", "<leader>/", function()
	fzf.live_grep({ cwd = fzf_cwd() })
end)
vim.keymap.set("v", "<leader>/", function()
	fzf.grep_visual({ cwd = fzf_cwd() })
end)
vim.keymap.set("n", "<leader>?", fzf.live_grep)
vim.keymap.set("v", "<leader>?", fzf.grep_visual)
vim.keymap.set("n", "<leader>gh", fzf.git_commits)
vim.keymap.set("n", "<leader>gH", fzf.git_bcommits)
vim.keymap.set("n", "<leader>gc", fzf.git_branches)
vim.keymap.set("n", "<leader>gs", fzf.git_stash)

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
