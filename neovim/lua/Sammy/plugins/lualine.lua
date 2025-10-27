-- Filename: ~/github/linux-dotfiles/neovim/lua/Sammy/plugins/lualine.lua

-- Other separator symbols:
-- █
--   
--   
--   
--   
--   

-- Require the colors.lua module and access the colors directly
local colors = require("Sammy.config.colors")
local icons = require("Sammy.config.icons")
local frames = require("Sammy.config.frames")

-- Cache system
local cache = {
    branch = "",
    branch_color = nil,
    commit_hash = "",
    file_permissions = { perms = "", color = colors["linkarzu_color03"] },
}

local fallbacks = {
    "lost",
    "bruh",
    "!false",
    "0.0.0.0"
}

local key_maps = {
    ["\r"] = "󱞥 ",
    ["\n"] = "󱞥 ",
    ["\t"] = "󰌒 ",
    ["\27[A"] = " ",
    ["\27[B"] = " ",
    ["\27[C"] = " ",
    ["\27[D"] = " ",
    ["<Down>"] = " ",
    ["<Up>"] = " "
}

local spinner_state = {
    active = false,
    frame = 1,
    timer = nil,
}

-- Local function to start the spinner
local function start_spinner()
    if spinner_state.active then
        return
    end

    spinner_state.active = true
    spinner_state.frame = 1

    spinner_state.timer = vim.loop.new_timer()

    spinner_state.timer:start(
        0,
        100,
        vim.schedule_wrap(function()
            spinner_state.frame = (spinner_state.frame % #frames.spinner) + 1
            vim.cmd("redrawstatus")
        end)
    )
end

-- Local function to start the spinner
local function stop_spinner()
    if spinner_state.timer then
        spinner_state.timer:stop()
        spinner_state.timer:close()
        spinner_state.timer = nil
    end
    spinner_state.active = false
    vim.cmd("redrawstatus")
end

-- Hook into LSP Progress notifications to keep a track of Language LSP status
vim.api.nvim_create_autocmd("LspProgress", {
    callback = function(args)
        local data = args.data or {}
        if data and data.value and data.value.kind == "end" then
            stop_spinner()
        else
            start_spinner()
        end
    end,
})

local function get_git_branch()
    local git_dir = vim.fn.systemlist("git rev-parse --git-dir 2>/dev/null")[1]
    if not git_dir or git_dir == "" then
        return fallbacks[math.random(#fallbacks)]
    end

    local branch = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD 2>/dev/null")[1]
    if not branch or branch == "" or branch == "HEAD" then
        -- detached HEAD or unknown branch
        local commit = vim.fn.systemlist("git rev-parse --short HEAD 2>/dev/null")[1] or "???"
        return " " .. commit
    end

    return branch ~= "" and branch or "meh"
end

-- Custom function to get the added, modified and removed for a specific github file
local function get_file_diff_counts()
    local file = vim.fn.expand("%:p")
    if file == "" then
        return nil
    end

    -- Check if inside a Git repo
    local is_repo = vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):gsub("%s+", "")
    if is_repo ~= "true" then
        return nil
    end

    -- Run git diff for the current file
    local diff_output = vim.fn.systemlist("git diff --numstat -- " .. vim.fn.shellescape(file))
    if vim.v.shell_error ~= 0 or #diff_output == 0 then
        return nil
    end

    -- Parse the "numstat" output: "<added> <removed> <filename>"
    local added, removed = diff_output[1]:match("(%d+)%s+(%d+)")
    added = tonumber(added) or 0
    removed = tonumber(removed) or 0

    -- Git doesn’t report "changed" lines explicitly, but you can estimate:
    local changed = math.min(added, removed)

    return {
        added = added,
        modified = changed,
        removed = removed,
    }
end

-- Set up autocmds for cache updates
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    callback = function()
        -- Update git branch
        cache.branch = get_git_branch()
        cache.branch_color = (cache.branch == "live") and { fg = colors["linkarzu_color11"], gui = "bold" } or nil

        -- Update commit hash only for dotfiles-latest repo
        local git_dir = vim.fn.system("git rev-parse --git-dir 2>/dev/null"):gsub("\n", "")
        if git_dir ~= "" then
            local repo_root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", "")
            if repo_root:match("dotfiles%-latest$") then
                cache.commit_hash = vim.fn.system("git rev-parse --short=7 HEAD"):gsub("\n", "")
            else
                cache.commit_hash = ""
            end
        else
            cache.commit_hash = ""
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    callback = function()
        if vim.bo.filetype ~= "sh" then
            cache.file_permissions = { perms = "", color = colors["linkarzu_color03"] }
            return
        end
        local file_path = vim.fn.expand("%:p")
        local permissions = file_path and vim.fn.getfperm(file_path) or "No File"
        local owner_permissions = permissions:sub(1, 3)
        cache.file_permissions = {
            perms = permissions,
            color = (owner_permissions == "rwx") and colors["linkarzu_color02"] or colors["linkarzu_color03"],
        }
    end,
})

-- Cached language mappings
local lang_map = {
    en = "EN",
    es = "ES",
}

local key_buffer = {}

local function get_venv_name()
    local venv = os.getenv("VIRTUAL_ENV")
    return venv and venv:match("([^/]+)$") or ""
end

local function get_spell_bg_color()
    return vim.wo.spell and colors["linkarzu_color02"] or colors["linkarzu_color08"]
end

local function should_show_permissions()
    return vim.bo.filetype == "sh" and vim.fn.expand("%:p") ~= ""
end

local function should_show_spell_status()
    return vim.bo.filetype == "markdown" and vim.wo.spell
end

local function get_spell_status()
    return (lang_map[vim.bo.spelllang] or vim.bo.spelllang)
end

local function get_file_permissions()
    if vim.bo.filetype ~= "sh" then
        return "", colors["linkarzu_color03"]
    end
    local file_path = vim.fn.expand("%:p")
    local permissions = file_path and vim.fn.getfperm(file_path) or "No File"
    local owner_permissions = permissions:sub(1, 3)
    return permissions, (owner_permissions == "rwx") and colors["linkarzu_color02"] or colors["linkarzu_color03"]
end

local function create_separator(condition)
    return {
        cond = condition,
        function()
            return ""
        end,
        color = { fg = colors["linkarzu_color14"], bg = colors["linkarzu_color17"] },
        separator = { left = "", right = "" },
        padding = 0,
    }
end

-- Function to maintain the key buffer upto last 3 pressed keys
-- Make the keys prettier as to just render them as buffers
local function prettify_key(char)
    if key_maps[char] then
        return key_maps[char]
    end

    local ok, translated = pcall(vim.fn.keytrans, char)
    if ok and translated and translated ~= "" then
        return translated
    end

    return string.format("<0x%02X>", string.byte(char))
end

vim.on_key(function(char)
    if not char or #char == 0 then
        return
    end
    local pretty = prettify_key(char)

    if pretty and pretty ~= "" then
        table.insert(key_buffer, 1, pretty)

        if #key_buffer > 3 then
            table.remove(key_buffer, #key_buffer)
        end
    end
end, vim.api.nvim_create_namespace("lualine-keys"))

local function get_last_keys()
    if #key_buffer == 0 then
        return ""
    end

    return table.concat(key_buffer, " ")
end

local function get_winbar_file_path()
    local bufname = vim.api.nvim_buf_get_name(0)
    local path = ""

    if bufname:match("^oil://") then
        path = bufname:gsub("^oil://", "")
    else
        path = bufname
    end

    -- Expand to full path and remove filename
    local dir = vim.fn.fnamemodify(path, ":p:h")

    -- Replace /home/sameer42 with ~/
    dir = dir:gsub("^/home/sameer42", "~")

    -- Split path by "/" and take only last 5 parts
    local parts = {}
    for part in dir:gmatch("[^/]+") do
        table.insert(parts, part)
    end

    local depth = 3
    local last_parts = {}
    local start_index = math.max(#parts - depth + 1, 1)

    if parts[1] == "~" then
        for i = 2, #parts do
            table.insert(last_parts, parts[i])
        end
    else
        last_parts = parts
    end

    -- Trim to depth
    if #last_parts > depth then
        local trimmed = {}
        for i = #last_parts - depth + 1, #last_parts do
            table.insert(trimmed, last_parts[i])
        end
        last_parts = trimmed
    end

    return "~/" .. table.concat(last_parts, "/")
end

return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    enabled = true,
    dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
    config = function()
        local lualine = require("lualine")

        -- Define custom theme based on your colors
        local custom_theme = {
            normal = {
                a = { fg = colors["linkarzu_color17"], bg = colors["linkarzu_color14"], gui = "bold" },
                b = { fg = colors["linkarzu_color02"], bg = "NONE" },
                c = { fg = colors["linkarzu_color03"], bg = "NONE" },
            },
            insert = {
                a = { fg = colors["linkarzu_color17"], bg = colors["linkarzu_color02"], gui = "bold" },
                b = { fg = colors["linkarzu_color02"], bg = "NONE" },
                c = { fg = colors["linkarzu_color03"], bg = "NONE" },
            },
            visual = {
                a = { fg = colors["linkarzu_color17"], bg = colors["linkarzu_color08"], gui = "bold" },
                b = { fg = colors["linkarzu_color02"], bg = "NONE" },
                c = { fg = colors["linkarzu_color03"], bg = "NONE" },
            },
            replace = {
                a = { fg = colors["linkarzu_color17"], bg = colors["linkarzu_color11"], gui = "bold" },
                b = { fg = colors["linkarzu_color02"], bg = "NONE" },
                c = { fg = colors["linkarzu_color03"], bg = "NONE" },
            },
            command = {
                a = { fg = colors["linkarzu_color17"], bg = colors["linkarzu_color10"], gui = "bold" },
                b = { fg = colors["linkarzu_color02"], bg = "NONE" },
                c = { fg = colors["linkarzu_color03"], bg = "NONE" },
            },
            inactive = {
                a = { fg = colors["linkarzu_color06"], bg = colors["linkarzu_color17"], gui = "bold" },
                b = { fg = colors["linkarzu_color06"], bg = "NONE" },
                c = { fg = colors["linkarzu_color06"], bg = "NONE" },
            },
        }

        lualine.setup({
            options = {
                theme = custom_theme,
                icons_enabled = true,
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                },
            },
            sections = {
                lualine_a = {
                    {
                        "mode",
                        icon = icons.vim.neovim,
                        separator = { left = "", right = "" },
                        padding = { left = 1, right = 1 },
                    },
                },
                lualine_b = {
                    {
                        function()
                            -- Return branch name and commit hash if available
                            return cache.branch .. (cache.commit_hash ~= "" and " " .. cache.commit_hash or "")
                        end,
                        icon = { icons.git.branch, color = { fg = colors["linkarzu_color04"] } },
                        color = function()
                            -- Use the cached branch color directly
                            return {
                                fg = colors["linkarzu_color04"],
                                -- bg = colors["linkarzu_color17"],
                                bg = "NONE",
                                gui =
                                "bold,italic"
                            }
                        end,
                        separator = { right = "" },
                        padding = { left = 1, right = 1 },
                    },
                    {
                        "diagnostics",
                        sources = { "nvim_diagnostic" },
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                        diagnostics_color = {
                            error = { fg = colors["error"] },
                            warn = { fg = colors["warning"] },
                            info = { fg = colors["linkarzu_color08"] },
                            hint = { fg = colors["linkarzu_color02"] },
                        },
                        colored = true,
                        color = { fg = colors["linkarzu_color11"], bg = "NONE", gui = "bold" },
                        separator = { left = "", right = "" },

                        -- Formatter for integrating loading state
                        -- fmt = function(str)
                        -- 	if spinner_state.active then
                        -- 		return frames.spinner[spinner_state.frame] .. " " .. str
                        -- 	end
                        -- 	return str
                        -- end,
                    },
                    -- {
                    --     get_venv_name,
                    --     icon = " ",
                    --     color = { fg = colors["linkarzu_color06"], bg = colors["sammy_color07"], gui = "italic" },
                    --     separator = { right = "" },
                    --     padding = { left = 1, right = 1 },
                    --     cond = function()
                    --         return get_venv_name() ~= ""
                    --     end,
                    -- },
                },
                lualine_c = {},
                lualine_x = {
                    -- {
                    --     "filename",
                    --     file_status = true,
                    --     path = 0,
                    --     shorting_target = 40,
                    --     separator = { left = "", right = "" },
                    --     symbols = {
                    --         modified = " ",
                    --         readonly = "󰌾 ",
                    --         unnamed = "[No Name]",
                    --         newfile = "󰝒 ",
                    --     },
                    --     color = function()
                    --         return { fg = colors["linkarzu_color07"], bg = colors["linkarzu_color04"], gui = "bold" }
                    --     end,
                    -- },
                    -- SPELLING left separator
                    -- create_separator(should_show_spell_status),
                    -- -- SPELLING component
                    -- {
                    -- 	get_spell_status,
                    -- 	cond = should_show_spell_status,
                    -- 	color = function()
                    -- 		return { fg = get_spell_bg_color(), bg = colors["linkarzu_color17"], gui = "bold" }
                    -- 	end,
                    -- 	separator = { left = "", right = "" },
                    -- 	padding = 1,
                    -- },
                    -- PERMISSIONS left separator
                    -- create_separator(should_show_permissions),
                    -- PERMISSIONS component
                    -- {
                    -- 	get_file_permissions,
                    -- 	cond = should_show_permissions,
                    -- 	color = function()
                    -- 		local _, bg_color = get_file_permissions()
                    -- 		return { fg = bg_color, bg = colors["linkarzu_color17"], gui = "bold" }
                    -- 	end,
                    --                    separator = { left = "", right = "" },
                    -- 	padding = 1,
                    -- },
                },
                lualine_y = {
                    {
                        "diff",
                        colored = true,
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                        diff_color = {
                            added = { fg = colors["git_added"] },
                            modified = { fg = colors["git_modified"] },
                            removed = { fg = colors["git_removed"] },
                        },
                        padding = { left = 1, right = 1 },
                    },
                    -- {
                    --     get_last_keys,
                    --     icon = " ", -- keyboard icon
                    --     color = { fg = colors["linkarzu_color14"], bg = colors["linkarzu_color17"], gui = "bold" },
                    --     padding = { left = 1, right = 1 },
                    --
                    -- },
                },
                lualine_z = {
                    -- {
                    --     "progress",
                    --     separator = { left = "", right = " " },
                    --     color = function()
                    --         return { fg = colors["linkarzu_color02"], bg = colors["sammy_color01"], gui = "bold" }
                    --     end,
                    --     padding = { left = 1, right = 0 },
                    -- },
                    {
                        "location",
                        color = function()
                            return { fg = colors["sammy_color06"], bg = colors["sammy_color01"], gui = "bold" }
                        end,
                        padding = { left = 1, right = 1 },
                        separator = { left = "" }
                    },
                },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1, color = { fg = colors["linkarzu_color24"], gui = "bold" } } },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = {
                    {
                        "filetype",
                        colored   = true, -- Displays filetype icon in color if set to true
                        icon_only = true, -- Display only an icon for filetype
                        padding   = { left = 1, right = 0 },
                        color     = { fg = colors["sammy_color05"], bg = "NONE", gui = "bold" },
                        separator = { left = "", right = "" },
                        icon      = { 'X', align = 'right' }
                        -- Icon string ^ in table is ignored in filetype component
                    },
                    {
                        "filename",
                        file_status = true,
                        path = 0,
                        shorting_target = 40,
                        separator = { left = "", right = "" },
                        symbols = {
                            modified = "",
                            readonly = "󰌾 ",
                            unnamed = "",
                            newfile = "󰝒 ",
                        },
                        color = function()
                            return { fg = colors["sammy_color06"], bg = "NONE", gui = "italic" }
                        end,
                    },
                },
                lualine_z = {
                    {
                        get_winbar_file_path,
                        color = { fg = colors["sammy_color06"], bg = "NONE", gui = "italic" },
                    },
                },
            },
            inactive_winbar = {
                lualine_a = {
                    {
                        "filetype",
                        colored = true,   -- Displays filetype icon in color if set to true
                        icon_only = true, -- Display only an icon for filetype
                        padding = { left = 1, right = 0 },
                        color = { fg = colors["linkarzu_color09"], bg = "NONE", gui = "italic" },
                        separator = { left = " ", right = "" },
                        icon = { 'X', align = 'right' }
                        -- Icon string ^ in table is ignored in filetype component
                    }
                },
                lualine_z = {
                    {
                        get_winbar_file_path,
                        color = { fg = colors["sammy_color06"], bg = "NONE", gui = "italic" },
                    },
                },
            },
            tabline = {},
            extensions = { "lazy", "fzf" },
        })
    end,
}
