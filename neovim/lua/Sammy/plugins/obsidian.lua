return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    cmd = { "Obsidian" },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    ft = { "markdown" },
    opts = {
        dir = "~/Documents/Obsidian Vault/",
        templates = {
            folder = "~/Documents/Obsidian Vault/5 - Template/",
            date_format = "%Y-%m-%d-%a",
            time_format = "%H-%M",
        },
    },
}
