return {
	-- requires pngpaste ( brew install pngpaste )
	"HakonHarnes/img-clip.nvim",
	event = "VeryLazy",
	keys = {
		-- suggested keymap
		{ "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
	},
	opts = {
		default = {
			dir_path = "~/Documents/Obsidian Vault/Assets/Attachments",
			extension = "png",
            file_name = function() return vim.fn.input("Name: ") end,
			relative_to_current_file = false, -- Currently using it only for Obsidian, will modify later if required

			-- Markdown formatting for Obsidian
			template = "![[$FILE_PATH|$CURSOR]]",
			url_encode_path = false,

			insert_mode_after_paste = true,
			use_cursor_in_template = true,

			prompt_for_file_name = false, -- Skipping Filename prompt, use the date method
			show_dir_path_in_prompt = true,

			use_absolute_path = true,
			embed_image_as_base64 = false,
			max_base64_size = 10,

			drag_and_drop = {
				enabled = true,
				insert_mode = true,
				copy_images = true,
				download_images = true,
			},
		},
        filetypes = {
            markdown = {
                template = function(context)
                    if string.find(context.filepath, "Obsidian Vault") then
                        return "![[$FILE_PATH|$CURSOR]]"
                    else
                        return "![$CURSOR]($FILE_PATH)"
                    end
                end
            }
        },

		-- add options here
		-- or leave it empty to use the default settings
	},
}
