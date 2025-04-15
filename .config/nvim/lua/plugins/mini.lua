---@diagnostic disable: duplicate-set-field
return {
	{
		"echasnovski/mini.icons",
		lazy = true,
		opts = {
			filetype = {
				dotenv = { glyph = "", hl = "MiniIconsYellow" },
			},
		},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		opts = {
			modes = { insert = true, command = false, terminal = false },
			skip_next = [=[[%w%%%'%[%'%.%`%$]]=],
			skip_ts = { "string" },
			skip_unbalanced = true,
			markdown = true,
		},
	},
	{
		"echasnovski/mini.statusline",
		config = function()
			local statusline = require("mini.statusline")
			local icons = require("mini.icons")
			statusline.setup({ use_icons = true })
			statusline.section_location = function() return "%2l:%-2v" end
			statusline.section_filename = function()
				local icon, _, _ = icons.get("filetype", vim.bo.filetype)
				return icon .. " " .. "%f%m%r"
			end
			statusline.section_fileinfo = function()
				local lazystatus = require("lazy.status")
				return lazystatus.has_updates() and lazystatus.updates() .. " " or ""
			end
		end,
	},
}

-- vim: ts=2 sts=2 sw=2 et
