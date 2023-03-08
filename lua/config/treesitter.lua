return function()
    local treesitter = require "nvim-treesitter"

    treesitter.setup({
        indent = {
            enable = true
        }
    })
end
