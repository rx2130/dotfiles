local metals = require("metals")

local metals_config = metals.bare_config()
metals_config.init_options.statusBarProvider = "on"
metals_config.settings = {
	showImplicitArguments = true,
	excludedPackages = { "--com.apple", "--apple" },
}
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

metals.initialize_or_attach(metals_config)

local dap = require("dap")
dap.configurations.scala = {
	{
		type = "scala",
		request = "launch",
		name = "Run or test",
		metals = {
			runType = "runOrTestFile",
		},
	},
	{
		type = "scala",
		request = "launch",
		name = "Test build target",
		metals = {
			runType = "testTarget",
		},
	},
}
