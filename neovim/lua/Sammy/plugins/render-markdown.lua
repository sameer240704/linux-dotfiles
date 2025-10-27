return {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ---@module 'render-markdown'
    -- ft = { "markdown", "norg", "rmd", "org" },
    init = function()
        -- Define colors
        local color1_bg = "#ff757f"
        local color2_bg = "#4fd6be"
        local color3_bg = "#7dcfff"
        local color4_bg = "#ff9e64"
        local color5_bg = "#7aa2f7"
        local color6_bg = "#c0caf5"
        local color_fg = "#1F2335"
        local color_unchecked = "#7aa2f7"
        local color_checked = "#9ece6a"

        -- -- Heading background
        vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s gui=bold]], color_fg, color1_bg))
        vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s gui=bold]], color_fg, color2_bg))
        vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s gui=bold]], color_fg, color3_bg))
        vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s gui=bold]], color_fg, color4_bg))
        vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s gui=bold]], color_fg, color5_bg))
        vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s gui=bold]], color_fg, color6_bg))

        -- Checkbox highlighting
        vim.cmd(string.format([[highlight RenderMarkdownUnchecked guifg=%s]], color_unchecked))
        vim.cmd(string.format([[highlight RenderMarkdownChecked guifg=%s gui=bold]], color_checked))

        -- Heading fg
        -- vim.cmd(string.format([[highlight Headline1Fg guifg=%s gui=bold]], colors.color1_bg))
        -- vim.cmd(string.format([[highlight Headline2Fg guifg=%s gui=bold]], colors.color2_bg))
        -- vim.cmd(string.format([[highlight Headline3Fg guifg=%s gui=bold]], colors.color3_bg))
        -- vim.cmd(string.format([[highlight Headline4Fg guifg=%s gui=bold]], colors.color4_bg))
        -- vim.cmd(string.format([[highlight Headline5Fg guifg=%s gui=bold]], colors.color5_bg))
        -- vim.cmd(string.format([[highlight Headline6Fg guifg=%s gui=bold]], colors.color6_bg))
    end,
    opts = {
        heading = {
            sign = false,
            icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
            backgrounds = {
                "Headline1Bg",
                "Headline2Bg",
                "Headline3Bg",
                "Headline4Bg",
                "Headline5Bg",
                "Headline6Bg",
            },
            foregrounds = {
                "Headline1Fg",
                "Headline2Fg",
                "Headline3Fg",
                "Headline4Fg",
                "Headline5Fg",
                "Headline6Fg",
            },
        },
        bullet = {
            -- Turn on / off list bullet rendering
            enabled = true,
            icons = { "●", "○", "◆", "◇" },
            highlight = "RenderMarkdownBullet",
        },
        checkbox = {
            -- Turn on / off checkbox state rendering
            enabled = true,
            -- Determines how icons fill the available space:
            --  inline:  underlying text is concealed resulting in a left aligned icon
            --  overlay: result is left padded with spaces to hide any additional text
            position = "overlay",
            unchecked = {
                -- Replaces '[ ]' of 'task_list_marker_unchecked'
                -- icon = "󰝦",
                icon = " 󰄱 ",
                -- Highlight for the unchecked icon
                highlight = "RenderMarkdownUnchecked",
                --      -- Highlight for item associated with unchecked checkbox
                -- scope_highlight = nil,
            },
            checked = {
                --      -- Replaces '[x]' of 'task_list_marker_checked'
                -- icon = "󰸞",
                icon = " 󰱒 ",
                -- Highlight for the checked icon
                highlight = "RenderMarkdownChecked",
                -- Highlight for item associated with checked checkbox
                -- scope_highlight = nil,
            },
        },
        -- For hyperlinks
        link = {
            enabled = true,
            image = " ",
            hyperlink = " ",
            highlight = "RenderMarkdownLink",
            custom = {
                web = { pattern = "^http", icon = "󰖟 " },
                discord = { pattern = "discord%.com", icon = " " },
                github = { pattern = "github%.com", icon = "󰊤 " },
                gitlab = { pattern = "gitlab%.com", icon = "󰮠 " },
                google = { pattern = "google%.com", icon = "󰊭 " },
                neovim = { pattern = "neovim%.io", icon = " " },
                reddit = { pattern = "reddit%.com", icon = "󰑍 " },
                stackoverflow = { pattern = "stackoverflow%.com", icon = "󰓌 " },
                wikipedia = { pattern = "wikipedia%.org", icon = "󰖬 " },
                youtube = { pattern = "youtube%.com", icon = "󰗃 " },
                twitter = { pattern = "twitter%.com", icon = "𝕏 " },
                telegram = { pattern = "telegram%.com", icon = " " },
                aws = { pattern = "(amazonaws%.com|aws%.amazon%.com)", icon = " " },
            },
        },

        -- For code blocks
        code = {
            enabled = true,
            sign = false,
            style = "language",
            position = "left",
            language_icon = true,
            language_name = true,
            disable_background = { "diff" },
            width = "full",
            left_margin = 0,
            left_pad = 0,
            right_pad = 0,
            min_width = 0,
            border = "hide",
            above = "▄",
            below = "▀",
            highlight = "RenderMarkdownCode",
        },

        -- Dashed Line
        dash = {
            enabled = true,
            icon = "─",
            width = "full",
            left_margin = 0,
            highlight = "RenderMarkdownDash",
        },

        -- Render Tables
        pipe_table = {
            enabled = true,
            cell = "padded",
            style = "normal",
            padding = 1,
            min_width = 15,
            alignment_indicator = "━",
            head = "RenderMarkdownTableHead",
            row = "RenderMarkdownTableRow",
            filler = "RenderMarkdownTableFill",
        },

        -- Callout
        callout = {
            note = {
                raw = "[!NOTE]",
                rendered = "󰋽 Note",
                highlight = "RenderMarkdownInfo",
                category = "github",
            },
            tip = {
                raw = "[!TIP]",
                rendered = "󰌶 Tip",
                highlight = "RenderMarkdownSuccess",
                category = "github",
            },
            important = {
                raw = "[!IMPORTANT]",
                rendered = "󰅾 Important",
                highlight = "RenderMarkdownHint",
                category = "github",
            },
            warning = {
                raw = "[!WARNING]",
                rendered = " Warning",
                highlight = "RenderMarkdownWarn",
                category = "github",
            },
            caution = {
                raw = "[!CAUTION]",
                rendered = "󰳦 Caution",
                highlight = "RenderMarkdownError",
                category = "github",
            },
            abstract = {
                raw = "[!ABSTRACT]",
                rendered = "󰨸 Abstract",
                highlight = "RenderMarkdownInfo",
                category = "obsidian",
            },
            summary = {
                raw = "[!SUMMARY]",
                rendered = "󰨸 Summary",
                highlight = "RenderMarkdownInfo",
                category = "obsidian",
            },
            tldr = {
                raw = "[!TLDR]",
                rendered = "󰨸 Tldr",
                highlight = "RenderMarkdownInfo",
                category = "obsidian",
            },
            info = {
                raw = "[!INFO]",
                rendered = "󰋽 Info",
                highlight = "RenderMarkdownInfo",
                category = "obsidian",
            },
            todo = {
                raw = "[!TODO]",
                rendered = "󰗡 Todo",
                highlight = "RenderMarkdownInfo",
                category = "obsidian",
            },
            hint = {
                raw = "[!HINT]",
                rendered = "󰌶 Hint",
                highlight = "RenderMarkdownSuccess",
                category = "obsidian",
            },
            success = {
                raw = "[!SUCCESS]",
                rendered = "󰄬 Success",
                highlight = "RenderMarkdownSuccess",
                category = "obsidian",
            },
            check = {
                raw = "[!CHECK]",
                rendered = "󰄬 Check",
                highlight = "RenderMarkdownSuccess",
                category = "obsidian",
            },
            done = {
                raw = "[!DONE]",
                rendered = "󰄬 Done",
                highlight = "RenderMarkdownSuccess",
                category = "obsidian",
            },
            question = {
                raw = "[!QUESTION]",
                rendered = "󰘥 Question",
                highlight = "RenderMarkdownWarn",
                category = "obsidian",
            },
            help = {
                raw = "[!HELP]",
                rendered = "󰘥 Help",
                highlight = "RenderMarkdownWarn",
                category = "obsidian",
            },
            faq = {
                raw = "[!FAQ]",
                rendered = "󰘥 Faq",
                highlight = "RenderMarkdownWarn",
                category = "obsidian",
            },
            attention = {
                raw = "[!ATTENTION]",
                rendered = "󰀪 Attention",
                highlight = "RenderMarkdownWarn",
                category = "obsidian",
            },
            failure = {
                raw = "[!FAILURE]",
                rendered = "󰅖 Failure",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            fail = {
                raw = "[!FAIL]",
                rendered = "󰅖 Fail",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            missing = {
                raw = "[!MISSING]",
                rendered = "󰅖 Missing",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            danger = {
                raw = "[!DANGER]",
                rendered = "󱐌 Danger",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            error = {
                raw = "[!ERROR]",
                rendered = "󱐌 Error",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            bug = {
                raw = "[!BUG]",
                rendered = "󰨰 Bug",
                highlight = "RenderMarkdownError",
                category = "obsidian",
            },
            example = {
                raw = "[!EXAMPLE]",
                rendered = "󰉹 Example",
                highlight = "RenderMarkdownHint",
                category = "obsidian",
            },
            quote = {
                raw = "[!QUOTE]",
                rendered = "󱆨 Quote",
                highlight = "RenderMarkdownQuote",
                category = "obsidian",
            },
            cite = {
                raw = "[!CITE]",
                rendered = "󱆨 Cite",
                highlight = "RenderMarkdownQuote",
                category = "obsidian",
            },
        },

        -- For rendering HTML
        html = {
            enabled = true,
            render_modes = false,
            tag = {},
        },
    },
}
