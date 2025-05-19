return {
	"romgrk/barbar.nvim",
	enabled = false,
	dependencies = {
		"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
		"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = true
	end,

	setup = function(overrides)
		require("barbar").setup({
			animation = true,
			auto_hide = true,
			tabpages = true,
			closable = true,
			clickable = true,
			exclude_ft = {},
			exclude_name = {},
            hide = {extensions = true, inactive = true},
            highlight_visible = true,
			icons = {
				filetype = {
					enabled = true,
				},
				separator = {
					left = "▎",
					right = "▎",
				},
				pinned = { button = "車" },
				button = "",
				modified = { button = "●" },
                gitsigns = {
                    added = {enabled = true, icon = '+'},
                    changed = {enabled = true, icon = '~'},
                    deleted = {enabled = true, icon = '-'},
                },

			},
			maximum_padding = 1,
			maximum_length = 30,
			semantic_letters = true,
			letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
			no_name_title = nil,
		})
	end,

	--    version = "^1.0.0",
}
