local on_attach = require("me.lsp").on_attach

local function jdtls_on_attach(client)
	on_attach(client)
	require("jdtls").setup_dap({ hotcodereplace = "auto" })
	require("jdtls.setup").add_commands()

	vim.keymap.set("n", "<leader>dt", require("jdtls").test_nearest_method, { buffer = true })
	vim.keymap.set("n", "<leader>dT", require("jdtls").test_class, { buffer = true })
end

local function start_jdt()
	local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
	local home = os.getenv("HOME")
	local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

	local ws_folders_jdtls = {}
	if root_dir then
		local file = io.open(root_dir .. "/.bemol/ws_root_folders", "r")
		if file then
			for line in file:lines() do
				table.insert(ws_folders_jdtls, string.format("file://%s", line))
			end
			file:close()
		end
	end

	local jar_patterns = {
		"/Developer/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
		"/Developer/vscode-java-decompiler/server/*.jar",
		"/Developer/vscode-java-test/server/*.jar",
	}
	local bundles = {}
	for _, jar_pattern in ipairs(jar_patterns) do
		for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
			if bundle ~= "" then
				table.insert(bundles, bundle)
			end
		end
	end

	local config = {
		on_attach = jdtls_on_attach,
		cmd = {
			"jdtls",
			"--jvm-arg=-javaagent:" .. home .. "/Developer/lombok.jar",
			"-data",
			eclipse_workspace,
		},
		root_dir = root_dir,
		init_options = {
			bundles = bundles,
			workspaceFolders = ws_folders_jdtls,
		},
		settings = {
			java = {
				signatureHelp = { enabled = true },
				contentProvider = { preferred = "fernflower" },
			},
		},
	}

	require("jdtls").start_or_attach(config)
end

start_jdt()
