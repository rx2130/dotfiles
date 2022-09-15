if vim.fn.filereadable("./gradlew") ~= 0 then
	vim.o.makeprg = "./gradlew build"
end
vim.bo.formatprg = "java -jar ~/Developer/apps/google-java-format-1.6-all-deps.jar -a -"

local jdtls = require("jdtls")
local on_attach = require("me.lsp").on_attach

local root_dir = require("jdtls.setup").find_root({ "packageInfo" }, "Config")
local home = os.getenv("HOME")
local eclipse_workspace = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local ws_folders_jdtls = {}
if root_dir then
	local file = io.open(root_dir .. "/.bemol/ws_root_folders")
	if file then
		for line in file:lines() do
			table.insert(ws_folders_jdtls, "file://" .. line)
		end
		file:close()
	end
end

local jar_patterns = {
	"/Developer/microsoft/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
	"/Developer/dgileadi/vscode-java-decompiler/server/*.jar",
	"/Developer/microsoft/vscode-java-test/server/*.jar",
}
local bundles = {}
for _, jar_pattern in ipairs(jar_patterns) do
	for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), "\n")) do
		if bundle ~= "" then
			table.insert(bundles, bundle)
		end
	end
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
local config = {
	on_attach = function(client)
		on_attach(client)
		jdtls.setup_dap({ hotcodereplace = "auto" })
		require("jdtls.setup").add_commands()

		vim.keymap.set("n", "<leader>dt", jdtls.test_nearest_method, { buffer = true })
		vim.keymap.set("n", "<leader>dT", jdtls.test_class, { buffer = true })
	end,
    capabilities = capabilities,
	cmd = {
		"jdtls",
		"--jvm-arg=-javaagent:" .. home .. "/Developer/apps/lombok.jar",
		"-data",
		eclipse_workspace,
	},
	root_dir = root_dir,
	init_options = {
		bundles = bundles,
		workspaceFolders = ws_folders_jdtls,
        extendedClientCapabilities = extendedClientCapabilities;
	},
	settings = {
		java = {
			signatureHelp = { enabled = true },
			contentProvider = { preferred = "fernflower" },
		},
	},
}

vim.lsp.handlers["language/status"] = function() end

jdtls.start_or_attach(config)
