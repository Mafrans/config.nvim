vim.cmd [[packadd packer.nvim]]

function setupCmp ()
  local cmp = require('cmp')
  local luasnip = require('luasnip')

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      ['<M-CR>'] = function()
        cmp.mapping.complete()
      end,
      
      ['<CR>'] = cmp.mapping({
        i = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
        c = function(fallback)
          if (cmp.visible() and cmp.get_selected_entry() ~= nil) then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback()
          end
        end
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, 
      { name = 'copilot' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
end

function setupLSP (servers)
  local lspconfig = require('lspconfig')
  local cmpnvimlsp = require('cmp_nvim_lsp');

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = cmpnvimlsp.update_capabilities(capabilities)

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({ capabilities = capabilities })
  end
end

 


return require('packer').startup(function()
  use { 
    'neovim/nvim-lspconfig',
    config = function()
      setupLSP({
        'tsserver',
        'tailwindcss',
        'intelephense',
        'gopls'
      })
    end
  }
  use { 'hoob3rt/lualine.nvim' }
  use { 'preservim/nerdtree' }
  use { 'preservim/nerdcommenter' }
  use { 'Xuyuanp/nerdtree-git-plugin' }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function() 
      require('nvim-web-devicons').setup({
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
  }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 
    'hrsh7th/nvim-cmp',
    config = function() 
      setupCmp()
    end
  }
  use { 'L3MON4D3/LuaSnip' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'rakr/vim-one' }
  use { 'folke/twilight.nvim' }
  use { 'norcalli/nvim-colorizer.lua' }
  use { 'sunjon/shade.nvim' }
  use { 'jghauser/mkdir.nvim' }
  use { 'romgrk/barbar.nvim' }
  use { 'moll/vim-bbye' }
  use { 
    'nvim-treesitter/nvim-treesitter', 
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup({
        indent = {
          enable = true
        }
      })
    end
  }
  use { 'folke/trouble.nvim' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'lewis6991/gitsigns.nvim' }
  use { 'nvim-telescope/telescope.nvim' }
  use { 
    'zbirenbaum/copilot.lua',
    event = { 'VimEnter' },
    config = function()
      vim.defer_fn(function()
        require('copilot').setup()
      end, 100)
    end,
  }
  use {
    'zbirenbaum/copilot-cmp',
    after = { 'copilot.lua', 'nvim-cmp' },
  }
  use { 'Thyrum/vim-stabs' }
end)

