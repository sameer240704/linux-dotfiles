return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            -- Styling for each Item of Snacks
            styles = {
                input = {
                    keys = {
                        n_esc = { "<C-c>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                        i_esc = { "<C-c>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    },
                },
            },
            -- Snacks Modules
            input = {
                enabled = false,
                backdrop = true,
                position = "float",
                border = "rounded",
                height = 1,
                width = 60,
                relative = "editor",
                title_pos = "center",
                wo = {
                    winhighlight =
                    "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
                    cursorline = false,
                },
                bo = {
                    filetype = "snacks_input",
                    buftype = "prompt",
                },
                b = {
                    completion = false, -- disable blink completions in input
                },
                keys = {
                    n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
                    i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
                    i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
                    i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
                    i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
                    i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
                    i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
                    q = "cancel",
                },
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = false,
                },
                formatters = {
                    file = {
                        filename_first = false,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    -- presets options : "default" , "ivy" , "ivy-split" , "telescope" , "vscode", "select" , "sidebar"
                    -- override picker layout in keymaps function as a param below
                    preset = "telescope", -- defaults to this layout unless overidden
                    cycle = false,
                },
                layouts = {
                    select = {
                        preview = false,
                        layout = {
                            backdrop = false,
                            width = 0.6,
                            min_width = 80,
                            height = 0.4,
                            min_height = 10,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input",   height = 1,          border = "bottom" },
                            { win = "list",    border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6,      height = 0.4, border = "top" },
                        },
                    },
                    telescope = {
                        reverse = true, -- set to false for search bar to be on top
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                {
                                    win = "input",
                                    height = 1,
                                    border = "rounded",
                                    title = "{title} {live} {flags}",
                                    title_pos = "center",
                                },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list",    border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                },
            },
            image = {
                enabled = true,
                doc = {
                    float = true,
                    inline = true, -- if you want show image on cursor hover
                    max_width = 50,
                    max_height = 30,
                    wo = {
                        wrap = true,
                    },
                },
                convert = {
                    notify = true,
                    command = "magick",
                },
                img_dirs = {
                    "img",
                    "images",
                    "assets",
                    "static",
                    "public",
                    "media",
                    "attachments",
                    "~/Pictures/",
                    "~/Downloads",
                    "~/Documents/",
                },
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys",   gap = 1, padding = 1 },
                    { section = "startup" },
                    {
                        section = "terminal",
                        cmd = "ascii-image-converter /home/sameer42/Pictures/Images/charizard.png -C -c",
                        random = 10,
                        pane = 2,
                        indent = 4,
                        height = 30,
                    },
                },
            },
            notifier = {
                enabled = true,
                timeout = 3000,
                border = "rounded",
                zindex = 100,
            },
            terminal = {
                win = {
                    style = "terminal"
                },
                bo = {
                    filetype = "snacks_terminal",
                },
                wo = {},
            },
        },
        keys = {
            {
                "<leader>un",
                function()
                    require("snacks").notifier.hide()
                end,
                desc = "Dismiss all notifications"
            },
            {
                "<leader>tt",
                function()
                    require("snacks").terminal.toggle()
                end,
                desc = ""
            },
            {
                "<leader>lg",
                function()
                    require("snacks").lazygit()
                end,
                desc = "Lazygit",
            },
            {
                "<leader>gl",
                function()
                    require("snacks").lazygit.log()
                end,
                desc = "Lazygit logs",
            },
            {
                "<S-r>",
                function()
                    require("snacks").rename.rename_file()
                end,
                desc = "Fast Rename Current File",
            },
            {
                "<leader>dB",
                function()
                    require("snacks").bufdelete()
                end,
                desc = "Delete or Close Buffer (Confirm)",
            },

            -- Snacks Picker
            {
                "<leader>pf",
                function()
                    require("snacks").picker.files()
                end,
                desc = "Find Files (Snacks Picker)",
            },
            {
                "<leader>pc",
                function()
                    require("snacks").picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "Find Config File",
            },
            {
                "<leader>ff",
                function()
                    require("snacks").picker.grep()
                end,
                desc = "Grep Word",
            },
            {
                "<leader>pws",
                function()
                    require("snacks").picker.grep_word()
                end,
                desc = "Search Visual Selection or Word",
                mode = { "n", "x" },
            },
            {
                "<leader>pk",
                function()
                    require("snacks").picker.keymaps({ layout = "ivy" })
                end,
                desc = "Search Keymaps (Snacks Picker)",
            },

            -- Git Stuff
            {
                "<leader>gbr",
                function()
                    require("snacks").picker.git_branches({ layout = "select" })
                end,
                desc = "Pick and Switch Git Branches",
            },

            -- Other Utils
            {
                "<leader>tcs",
                function()
                    require("snacks").picker.colorschemes({ layout = "ivy" })
                end,
                desc = "Pick Color Schemes",
            },
            {
                "<leader>vh",
                function()
                    require("snacks").picker.help()
                end,
                desc = "Help Pages",
            },
            -- {
            -- 	":",
            -- 	function()
            -- 		require("snacks").input({
            -- 			prompt = "Command: ",
            -- 		}, function(input)
            -- 			if input and #input > 0 then
            -- 				vim.cmd(input)
            -- 			end
            -- 		end)
            -- 	end,
            -- 	desc = "Snacks Command Input",
            -- },
            -- {
            -- 	"/",
            -- 	function()
            -- 		require("snacks").input({
            -- 			prompt = "Search: ",
            -- 		}, function(input)
            -- 			if input and #input > 0 then
            -- 				vim.fn.setreg("/", input)
            -- 				vim.cmd("normal! n")
            -- 			end
            -- 		end)
            -- 	end,
            -- 	desc = "Snacks Search Input",
            -- },
            -- {
            -- 	"?",
            -- 	function()
            -- 		require("snacks").input({
            -- 			prompt = "Search Backward: ",
            -- 		}, function(input)
            -- 			if input and #input > 0 then
            -- 				vim.fn.setreg("/", input)
            -- 				vim.cmd("normal! N")
            -- 			end
            -- 		end)
            -- 	end,
            -- 	desc = "Snacks Search Backward Input",
            -- },
        },
    },
    -- NOTE: todo comments w/ snacks
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            {
                "<leader>pt",
                function()
                    require("snacks").picker.todo_comments()
                end,
                desc = "Todo",
            },
            {
                "<leader>pT",
                function()
                    require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
                end,
                desc = "Todo/Fix/Fixme",
            },
        },
    },
}
