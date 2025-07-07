vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

vim.g.fubitive_domain_pattern = (("vwdvk1vg1dssoh1frp"):gsub('.',function(c)return string.char((c:byte()-3)%256)end))

if os.getenv("SSH_CLIENT") then
	local osc52 = require("vim.ui.clipboard.osc52")
	vim.g.clipboard = {
		name = "OSC 52",
		copy = {
			["+"] = osc52.copy("+"),
		},
		paste = {
			["+"] = osc52.paste("+"),
		},
	}
end

local utils = require("fzf-lua.utils")
vim.keymap.set({ "n", "v" }, "gX", function()
	local query = vim.fn.mode() == "n" and vim.fn.expand("<cWORD>") or utils.get_visual_selection()
	local url = query:match("https?://[%w%.%+%-%?_:/=&#]+")
	if url == nil then
		local escaped = vim.uri_encode(query)
		url = ("https://www.google.com/search?q=%s"):format(escaped)
	end
	vim.ui.open(url)
end)

vim.keymap.set("n", "<leader>t", require("me.term").toggle)

vim.api.nvim_create_user_command("Root", function()
	local root = vim.fs.root(0, ".git")
	if root then
		vim.fn.chdir(root)
	end
end, {})

-- treesitter
require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	indent = {
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
			vim.snippet.expand(args.body)
		end,
	},
	mapping = {
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-Space>"] = cmp.mapping.complete(),
		-- ["<Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_next_item()
		-- 	elseif luasnip.expand_or_jumpable() then
		-- 		luasnip.expand_or_jump()
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
		-- ["<S-Tab>"] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.select_prev_item()
		-- 	elseif luasnip.jumpable(-1) then
		-- 		luasnip.jump(-1)
		-- 	else
		-- 		fallback()
		-- 	end
		-- end, {
		-- 	"i",
		-- 	"s",
		-- }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
	},
	sources = {
		{ name = "nvim_lsp_signature_help" },
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
	experimental = {
		ghost_text = true,
	},
})

-- mini
require("mini.notify").setup()

local neigh_pattern = ".[^%w(%[{'\"]"
require("mini.pairs").setup({
	mappings = {
		["("] = { action = "open", pair = "()", neigh_pattern = neigh_pattern },
		["["] = { action = "open", pair = "[]", neigh_pattern = neigh_pattern },
		["{"] = { action = "open", pair = "{}", neigh_pattern = neigh_pattern },
	},
})

require("mini.misc").setup({})
MiniMisc.setup_auto_root()
MiniMisc.setup_restore_cursor()

require("mini.surround").setup({
	mappings = {
		add = "ys",
		delete = "ds",
		find = "",
		find_left = "",
		highlight = "",
		replace = "cs",
		update_n_lines = "",
		-- Add this only if you don't want to use extended mappings
		suffix_last = "",
		suffix_next = "",
	},
	search_method = "cover_or_next",
})
-- Remap adding surrounding to Visual mode selection
vim.api.nvim_del_keymap("x", "ys")
vim.api.nvim_set_keymap("x", "S", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
-- Make special mapping for "add surrounding for line"
vim.api.nvim_set_keymap("n", "yss", "ys_", { noremap = false })

require("mini.diff").setup({
	view = {
		signs = { add = "│", change = "│", delete = "_" },
		priority = 0,
	},
	mappings = {
		goto_first = "[C",
		goto_prev = "[c",
		goto_next = "]c",
		goto_last = "]C",
	},
})

require("mini.basics").setup({
	mappings = {
		option_toggle_prefix = [[yo]],
		windows = true,
	},
})

require("mini.bracketed").setup({
	comment = { suffix = "", options = {} },
})

vim.keymap.set("n", "[ ", "v:lua.MiniBasics.put_empty_line(v:true)", { expr = true, desc = "Put empty line above" })
vim.keymap.set("n", "] ", "v:lua.MiniBasics.put_empty_line(v:false)", { expr = true, desc = "Put empty line below" })
vim.keymap.set({ "n", "x" }, "[p", '<Cmd>exe "put! " . v:register<CR>', { desc = "Paste Above" })
vim.keymap.set({ "n", "x" }, "]p", '<Cmd>exe "put "  . v:register<CR>', { desc = "Paste Below" })

require("mini.move").setup({
	mappings = {
		up = "[e",
		down = "]e",
		line_up = "[e",
		line_down = "]e",
	},
})

require("mini.operators").setup({
	evaluate = {
		prefix = "g=",
	},
	exchange = {
		prefix = "cx",
		reindent_linewise = true,
	},
	multiply = {
		prefix = "gm",
	},
	replace = {
		prefix = "<Leader>r",
		reindent_linewise = true,
	},
	sort = {
		prefix = "gs",
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
		rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 --multiline --hidden -g '!{.git,node_modules}/'",
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
	local root_dir = vim.fs.dirname(vim.fs.find("packageInfo", { upward = true, type = "file" })[1])
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
require("nvim-tree").setup({
	git = {
		ignore = false,
	},
	view = {
		signcolumn = "auto",
		width = {
			max = 50,
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
	on_attach = function(bufnr)
		local api = require("nvim-tree.api")
		api.config.mappings.default_on_attach(bufnr)
		vim.keymap.set("n", "<C-s>", api.node.open.horizontal)
		vim.keymap.del("n", "<C-e>", { buffer = bufnr })
	end,
})
