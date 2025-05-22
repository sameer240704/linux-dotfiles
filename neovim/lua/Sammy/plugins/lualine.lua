return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status") -- to configure lazy pending updates count

		local colors = {
			color0 = "#092236",
			color1 = "#ff5874",
			color2 = "#c3ccdc",
			color3 = "#1c1e26",
			color6 = "#a1aab8",
			color7 = "#828697",
			color8 = "#ae81ff",
		}
		local my_lualine_theme = {
			replace = {
				a = { fg = colors.color0, bg = colors.color1, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			inactive = {
				a = { fg = colors.color6, bg = colors.color3, gui = "bold" },
				b = { fg = colors.color6, bg = colors.color3 },
				c = { fg = colors.color6, bg = colors.color3 },
			},
			normal = {
				a = { fg = colors.color0, bg = colors.color7, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
				c = { fg = colors.color2, bg = colors.color3 },
			},
			visual = {
				a = { fg = colors.color0, bg = colors.color8, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
			insert = {
				a = { fg = colors.color0, bg = colors.color2, gui = "bold" },
				b = { fg = colors.color2, bg = colors.color3 },
			},
		}

		local mode = {
			"mode",
			fmt = function(str)
				-- return ' '
				-- displays only the first character of the mode
				return " " .. str
			end,
		}

		local diff = {
			"diff",
			colored = true,
			symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
			-- cond = hide_in_width,
		}

		local filename = {
			"filename",
			file_status = true,
			path = 0,
		}

		local branch = { "branch", icon = { "", color = { fg = "#A6D4DE" } }, "|" }

		lualine.setup({
			icons_enabled = true,
			options = {
				theme = my_lualine_theme,
				-- component_separators = { left = "|", right = "|" },
                component_separators = '',
				section_separators = { left = "", right = "" },
                disabled_filetypes = {},
                globalstatus = true,
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
				lualine_b = { branch },
				lualine_c = { diff, filename },
				lualine_x = {
					{
						-- require("noice").api.statusline.mode.get,
						-- cond = require("noice").api.statusline.mode.has,
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					-- { "encoding",},
					-- { "fileformat" },
					{ "filetype" },
				},
			},
            tabline = {},
            extensions = {},
		})
	end,
}

-- return {
-- 	"nvim-lualine/lualine.nvim",
-- 	dependencies = { "nvim-tree/nvim-web-devicons" },
-- 	config = function()
-- 		local lualine = require("lualine")
-- 		local lazy_status = require("lazy.status")
--
-- 		local colors = {
-- 			black = "#1c1e26",
-- 			gray = "#343b4f",
-- 			white = "#ffffff",
-- 			blue = "#80a0ff",
-- 			green = "#8fff6d",
-- 			violet = "#ae81ff",
-- 			cyan = "#56c8d8",
-- 			red = "#ff5874",
-- 			orange = "#ff9e64",
-- 		}
--
-- 		local bubble_theme = {
-- 			normal = {
-- 				a = { fg = colors.black, bg = colors.blue, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.gray },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 			insert = {
-- 				a = { fg = colors.black, bg = colors.green, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.gray },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 			visual = {
-- 				a = { fg = colors.black, bg = colors.violet, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.gray },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 			replace = {
-- 				a = { fg = colors.black, bg = colors.red, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.gray },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 			command = {
-- 				a = { fg = colors.black, bg = colors.orange, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.gray },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 			inactive = {
-- 				a = { fg = colors.white, bg = colors.black, gui = "bold" },
-- 				b = { fg = colors.white, bg = colors.black },
-- 				c = { fg = colors.white, bg = colors.black },
-- 			},
-- 		}
--
-- 		local branch = {
-- 			"branch",
-- 			icon = { "", color = { fg = colors.cyan } },
-- 		}
--
-- 		local diff = {
-- 			"diff",
-- 			colored = true,
-- 			symbols = {
-- 				added = " ",
-- 				modified = " ",
-- 				removed = " ",
-- 			},
-- 		}
--
-- 		local diagnostics = {
-- 			"diagnostics",
-- 			sources = { "nvim_diagnostic" },
-- 			sections = { "error", "warn", "info", "hint" },
-- 			symbols = { error = " ", warn = " ", info = " ", hint = " " },
-- 			diagnostics_color = {
-- 				error = { fg = colors.red },
-- 				warn  = { fg = colors.orange },
-- 				info  = { fg = colors.cyan },
-- 				hint  = { fg = colors.green },
-- 			},
-- 		}
--
-- 		lualine.setup({
-- 			options = {
-- 				theme = bubble_theme,
-- 				component_separators = '',
-- 				section_separators = { left = "", right = "" },
-- 				disabled_filetypes = {},
-- 				globalstatus = true,
-- 			},
-- 			sections = {
-- 				lualine_a = {
-- 					{ "mode", separator = { left = "", right = "" }, right_padding = 2 }
-- 				},
-- 				lualine_b = { branch, diff },
-- 				lualine_c = { diagnostics },
-- 				lualine_x = {
-- 					{
-- 						lazy_status.updates,
-- 						cond = lazy_status.has_updates,
-- 						color = { fg = colors.orange },
-- 					},
-- 					{ "filetype" }
-- 				},
-- 				lualine_y = { "progress" },
-- 				lualine_z = {
-- 					{ "location", separator = { left = "", right = "" }, left_padding = 2 }
-- 				},
-- 			},
-- 			inactive_sections = {
-- 				lualine_a = {},
-- 				lualine_b = {},
-- 				lualine_c = { "filename" },
-- 				lualine_x = { "location" },
-- 				lualine_y = {},
-- 				lualine_z = {},
-- 			},
-- 			tabline = {},
-- 			extensions = {},
-- 		})
-- 	end,
-- }

