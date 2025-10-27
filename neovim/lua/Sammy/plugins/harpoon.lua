return {
    "thePrimeagen/harpoon",
    enabled = true,
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },

    config = function()
        local harpoon = require("harpoon")

        harpoon.setup({
            global_settings = {
                save_on_toggle = true,
                save_on_change = true,
            },
        })

        -- Harpoon Navigation Bar
        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon Navigation Bar Toggle" })
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        -- Harpoon Marked Files
        vim.keymap.set("n", "<A-1>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<A-2>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<A-3>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<A-4>", function() harpoon:list():select(4) end)
        vim.keymap.set("n", "<A-5>", function() harpoon:list():select(5) end)
        vim.keymap.set("n", "<A-6>", function() harpoon:list():select(6) end)
        vim.keymap.set("n", "<A-7>", function() harpoon:list():select(7) end)
        vim.keymap.set("n", "<A-8>", function() harpoon:list():select(8) end)
        vim.keymap.set("n", "<A-9>", function() harpoon:list():select(9) end)


        -- Toogle previous and next buffers within the harpoon list
        vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
        vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
    end
}
