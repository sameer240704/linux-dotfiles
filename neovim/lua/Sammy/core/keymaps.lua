local opts = { noremap = true, silent = true }

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move lines up" })

vim.keymap.set("n", "J", "mzJ`z", { noremap = true, silent = true, desc = "Joins below line with the current keeping the cursor in place" })

vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Clipboard Things
-- Paste without replacing the clipboard content
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set("v", "p", '"_dp', opts)

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-c>", ":nohl<CR>", { desc = "Clear search highlight", silent = true })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlighting when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Diagnostics Auto-Command
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = vim.api.nvim_create_augroup("float_diagnostics", { clear = true }),
    callback = function ()
        vim.diagnostic.open_float(nil, {
            focus = false,
            border = "rounded"
        })
    end,
})

-- Tab Stuff
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>")  -- open new tab
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>")  -- close current tab
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>")  -- go to next tab
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>")  -- go to prev tab
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>")  -- open current tab in new tab

-- Copy filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~")  -- Gets the file path relative to the home directory
    vim.fn.setreg("+", filePath)  -- Copy the filepath to the clipboard register
    print("File path copied to the clipboard: " .. filePath)
end, {desc = "Copy file path to clipboard" })

-- Toggle LSP Diagnostics Visibilty
local isLspDiagnosticsVisible = true
vim.keymap.set("n", "<leader>lx", function()
    isLspDiagnosticsVisible = not isLspDiagnosticsVisible
    vim.diagnostic.config({
        virtual_text = isLspDiagnosticsVisible,
        underline = isLspDiagnosticsVisible
    })
end, { desc = "Toggle LSP Diagnostic" })
