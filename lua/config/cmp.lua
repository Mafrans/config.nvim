local utils = require "utils"

return function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    local function handleTab(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        elseif utils.cursorHasWordsBefore() then
            cmp.complete()
        else
            fallback()
        end
    end

    local function handleShiftTab(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end

    local function handleWinReturn(fallback)
        cmp.mapping.complete()
    end

    local function handleReturn(fallback)
        if (cmp.visible() and cmp.get_selected_entry() ~= nil) then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
        else
            fallback()
        end
    end

    cmp.setup({
        snippet = {
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = {
            ["<Tab>"] = cmp.mapping(handleTab, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(handleShiftTab, { "i", "s" }),
            ["<M-CR>"] = cmp.mapping(handleWinReturn, { "i", "s" }),
            ["<CR>"] = cmp.mapping({
                i = handleReturn,
                c = handleReturn
            }),
        },
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "copilot" },
        }, {
            { name = "buffer" },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
            { name = "buffer" },
        })
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline("/", {
        sources = {
            { name = "buffer" }
        }
    })

    -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won"t work anymore).
    cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
            { name = "path" }
        }, {
            { name = "cmdline" }
        })
    })
end
