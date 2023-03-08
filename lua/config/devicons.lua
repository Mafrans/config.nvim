return function()
    local devicons = require "nvim-web-devicons"

    devicons.setup({
        override = {
            zsh = {
                icon = "",
                color = "#428850",
                name = "Zsh"
            }
        },
        default = true
    })
end
