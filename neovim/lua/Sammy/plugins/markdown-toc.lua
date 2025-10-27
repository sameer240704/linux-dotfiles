return {
    "hedyhli/markdown-toc.nvim",
    ft = "markdown", -- Lazy load on markdown filetype
    cmd = { "Mtoc" }, -- Or, lazy load on "Mtoc" command
    opts = {
        headings = {
            before_toc = false,
            exclude = {},
            pattern = "^(#+)%s+(.+)$",
        },
        toc_list = {
            markers = "*",
            cycle_markers = false,
            indent_size = 2,
            item_format_string = "${indent}${marker} [${name}](#${link})",
        },
    },
}
