return {
	"gelguy/wilder.nvim",
	-- "nvim-telescope/telescope.nvim",
	-- enabled = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"romgrk/fzy-lua-native",
	},
	config = function()
		local wilder = require("wilder")
		wilder.setup({ modes = { ":", "/", "?" } })

		-- Enabling Fuzzy Matching in WilderPopupMenu
		wilder.set_option("pipeline", {
			wilder.branch(
				wilder.cmdline_pipeline({
					fuzzy = 1,
					fuzzy_filter = wilder.lua_fzy_filter(),
				}),
				wilder.vim_search_pipeline()
			),
		})

		-- Define custom highlight groups
		wilder.set_option(
			"renderer",
			wilder.popupmenu_renderer(wilder.popupmenu_palette_theme({
				min_width = "40%", -- minimum height of the popupmenu, can also be a number
				max_height = "50%", -- to set a fixed height, set max_height to the same value
				reverse = 0, -- if 1, shows the candidates from bottom to top
				pumblend = 20,
				highlighter = {
					wilder.basic_highlighter(),
					wilder.lua_pcre2_highlighter(), -- Requires luarocks install pcre2
					wilder.lua_fzy_highlighter(), -- Requires fzy-lua-native
				},
				left = {
					" ",
					wilder.popupmenu_devicons(),
					wilder.popupmenu_buffer_flags({
						flags = " a + ",
						icons = { ["+"] = "", a = "", h = "" },
					}),
				},
				right = {
					" ",
					wilder.popupmenu_scrollbar(),
				},
				highlights = {
					default = wilder.make_hl(
						"WilderPopupMenu",
						"Pmenu",
						{ { a = 1 }, { a = 1 }, { background = "#1E212B" } } -- Adjust background color
					),
					accent = wilder.make_hl(
						"WilderAccent",
						"Pmenu",
						{ { a = 1 }, { a = 1 }, { foreground = "#58FFD6", background = "#1e1e2e" } }
					),
				},
				-- 'single', 'double', 'rounded' or 'solid'
				-- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
				border = "rounded",
				win_position = "center",
				prompt_position = "bottom",
			}))
		)
		-- Custom highlight groups
		vim.api.nvim_set_hl(0, "WilderSelected", { bg = "#45475a", fg = "#f8f8f2", bold = true })
		vim.api.nvim_set_hl(0, "WilderAccent", { fg = "#f4468f" })
		vim.api.nvim_set_hl(0, "WilderBorder", { fg = "#6c7086" })
	end,
}
