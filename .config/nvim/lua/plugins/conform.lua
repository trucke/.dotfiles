return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		notify_on_error = false,
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			go = { "goimports", "gofumpt", lsp_format = "fallback" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
		-- format_on_save = { timeout_ms = 500 },
		formatters = {
			shfmt = { prepend_args = { "-i", "2" } },
		},
	},
	init = function()
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}

-- vim: ts=2 sts=2 sw=2 et
