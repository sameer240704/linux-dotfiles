vim.cmd("let g:netrw_banner = 0")

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true

vim.opt.incsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.backspace = { "start", "eol", "indent" }

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

vim.opt.clipboard:append("unnamedplus")
vim.opt.hlsearch = true

vim.opt.mouse = "a"
vim.g.editorconfig = true

-- Obsidian
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.g.markdown_recommended_style = 0
		vim.opt_local.conceallevel = 2
	end,
})

-- Update on Daily To-Do List
-- vim.api.nvim_create_autocmd("BufRead", {
--   pattern = "*/to-do.md",
-- callback = function()
--   local content = vim.fn.readfile(vim.fn.expand("%"))
-- if #content > 0 and content[1]:match("# To-Do") then
--   content[1] = "# To-Do - " .. os.date("%Y-%m-%d")
--   vim.fn.writefile(content, vim.fn.expand("%"))
-- end
--   end
-- })

-- Window layout setup (Only setup notes sidebar when no arguments are provided)
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     -- Check if we opened with a file/folder argument
--     local should_open_sidebar = true
--
--     -- Don't open sidebar if:
--     -- 1. We opened with file arguments
--     -- 2. We opened a directory (like with 'nvim .')
--     if #vim.fn.argv() > 0 or vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
--       should_open_sidebar = false
--     end
--
--     if should_open_sidebar then
--       -- Open notes in vertical split (20% width)
--       vim.cmd("vsplit ~/Documents/to-do.md")
--
--       -- Configure notes window
--       vim.cmd("wincmd l")  -- Move to right window
--       vim.cmd("set winfixwidth")  -- Fixed width
--       vim.cmd("vertical resize " .. math.floor(vim.o.columns * 0.2))
--
--       -- Configure main terminal window (80% width)
--       vim.cmd("wincmd h")  -- Move back to left window
--       vim.cmd("terminal")
--       vim.cmd("startinsert")  -- Focus the terminal
--     end
--   end
-- })

-- Subtle border to the To-Do box
-- vim.api.nvim_set_hl(0, 'VertSplit', { fg = '#3a3a3a', bg = 'NONE' })
