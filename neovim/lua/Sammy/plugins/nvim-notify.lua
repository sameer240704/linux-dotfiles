return {
    "rcarriga/nvim-notify",
    enabled = false,
    config = function()
        local notify = require("notify")

        notify.setup({
            timeout = 3000,
            stages = "fade_in_slide_out",
            background_colour = "#000000"
        })
    end,
}
