return {
	"nvim-lualine/lualine.nvim",
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_b = { "branch" },
			lualine_c = {
				{ "diagnostics" },
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				{ "filename" },
			},
			lualine_x = {
				{
					function() return require("noice").api.status.mode.get() end,
					cond = function()
						return package.loaded["noice"] and require("noice").api.status.mode.has()
					end,
				},
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
				},
			},
		},
		extensions = { "lazy", "fzf" },
	},
}

-- vim: ts=2 sts=2 sw=2 et
