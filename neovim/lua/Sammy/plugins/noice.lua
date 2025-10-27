return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        enabled = true,
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            local noice = require("noice")

            noice.setup({
                cmdline = {
                    enabled = true, -- Currently the cmdline is coming at the center and the suggestions are coming at the bottom
                    view = "cmdline_popup",
                    opts = {},
                    format = {
                        cmdline = { pattern = "^:", icon = " ", lang = "vim" },
                        search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
                        search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
                        filter = { pattern = "^:%s*!", icon = "󰈲 ", lang = "bash" },
                        input = { view = "cmdline_input", icon = " 󰌌 :" }, -- Used by input()
                    },
                },
                notify = {
                    enabled = true,
                    view = "notify",
                },
                views = {
                    cmdline_popup = {
                        position = {
                            row = 10,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = "auto",
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                            text = { top = " Command ", align = "center" },
                        },
                        win_options = {
                            winhighlight = {
                                Normal = "NormalFloat",
                                FloatBorder = "FloatBorder",
                            },
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 13,
                            col = "50%",
                        },
                        size = {
                            width = 40,
                            height = 10,
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
                    mini = {
                        size = {
                            width = "auto",
                            height = "auto",
                            max_height = 15,
                        },
                        position = {
                            row = -2,
                            col = "100%",
                        },
                    },
                },
                lsp = {
                    progress = {
                        enabled = true,
                        format = "lsp_progress",
                        format_done = "lsp_progress_done",
                        view = "mini",
                        throttle = 1000 / 30,
                    },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                    },
                    hover = {
                        enabled = true,
                        view = nil,
                        opts = {},
                    },
                    signature = {
                        enabled = true,
                        auto_open = { enabled = true, trigger = true, luasnip = true, throttle = 50 }, -- disable auto signature help on insert mode
                        view = nil,
                        opts = {}
                    },
                    message = {
                        enabled = true,
                        view = "notify",
                        opts = {}
                    },
                    documentation = {
                        view = "hover",
                        opts = {
                            lang = "markdown",
                            replace = true,
                            render = "plain",
                            format = { "message" },
                            win_options = { concealcursor = "n", conceallevel = 3 }
                        }
                    }
                },
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            any = {
                                { find = "%d+L, %d+B" },
                                { find = "; after #%d+" },
                                { find = "; before #%d+" },
                                { find = "%d fewer lines" },
                                { find = "%d more lines" },
                            },
                        },
                        opts = { skip = true },
                    },
                },
                messages = {
                    enabled = true,
                    view = "notify",
                    view_error = "notify",
                    view_warn = "notify",
                    view_history = "messages",
                    view_search = "virtualtext",
                },
                redirect = {
                    view = "popup",
                    filter = { event = "msg_show" }
                },
                commands = {
                    history = {
                        view = "split",
                        opts = { enter = true, format = "details" },
                        filter = {
                            any = {
                                { event = "notify" },
                                { error = true },
                                { warning = true },
                                { event = "msg_show", kind = { "" } },
                                { event = "lsp",      kind = "message" },
                            },
                        },
                    },
                    last = {
                        view = "popup",
                        opts = { enter = true, format = "details" },
                        filter = {
                            any = {
                                { event = "notify" },
                                { error = true },
                                { warning = true },
                                { event = "msg_show", kind = { "" } },
                                { event = "lsp",      kind = "message" },
                            },
                        },
                        filter_opts = { count = 1 }
                    },
                    errors = {
                        view = "popup",
                        opts = { enter = true, format = "details" },
                        filter = { error = true },
                        filter_opts = { reverse = true }
                    },
                    all = {
                        view = "split",
                        opts = { enter = true, format = "details" },
                        filter = {},
                    }
                },
                health = {
                    checker = true,
                },
                popupmenu = {
                    enabled = true,
                    backend = "nui",
                    kind_icons = {}
                },
                signature = {
                    enabled = true,
                },
            })
        end,
    },
}
