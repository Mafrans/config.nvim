noremap j h
noremap k j
noremap i k
inoremap jj <Esc>
nnoremap <Esc> i
nnoremap <c-t> :tabe<CR>
nnoremap <silent> <c-j> :BufferPrevious<CR>
nnoremap <silent> <c-l> :BufferNext<CR>
nnoremap <silent> <a-1> :BufferGoto 1<CR>
nnoremap <silent> <a-2> :BufferGoto 2<CR>
nnoremap <silent> <a-3> :BufferGoto 3<CR>
nnoremap <silent> <a-4> :BufferGoto 4<CR>
nnoremap <silent> <a-5> :BufferGoto 5<CR>
nnoremap <silent> <a-6> :BufferGoto 6<CR>
nnoremap <silent> <a-7> :BufferGoto 7<CR>
nnoremap <silent> <a-8> :BufferGoto 8<CR>
nnoremap <silent> <a-9> :BufferLast<CR>
nnoremap <silent> <a-p> :BufferPin<CR>
nnoremap <silent> <c-w> :BufferClose<CR>

set number
set termguicolors
set hidden
set shiftwidth=4
set mouse+=a

"
" PLUGIN CONFIGURATION
"
call plug#begin(stdpath('data') . '/plugged')

Plug 'neovim/nvim-lspconfig'
Plug 'hoob3rt/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'rakr/vim-one'
Plug 'folke/twilight.nvim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sunjon/shade.nvim'
Plug 'jghauser/mkdir.nvim'
Plug 'romgrk/barbar.nvim'
Plug 'moll/vim-bbye'

call plug#end()

" SET THEME TO 'one'
let g:airline_theme='one'
colorscheme one
set background=light

" CONFIGURE PLUGINS
lua << EOF
require'shade'.setup({
  overlay_opacity = 50,
  opacity_step = 1,
  keys = {
    brightness_up    = '<C-Up>',
    brightness_down  = '<C-Down>',
    toggle           = '<Leader>s',
  }
})
require'colorizer'.setup()
require'twilight'.setup{}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.gopls.setup{}
require'lualine'.setup()
require'nvim-web-devicons'.setup {
    -- your personnal icons can go here (to override)
    -- DevIcon will be appended to `name`
    override = {
	zsh = {
	    icon = "",
	    color = "#428850",
	    name = "Zsh"
	}
    };
    -- globally enable default icons (default to false)
    -- will get overriden by `get_icons` option
    default = true;
}
require'compe'.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = {
	-- the border option is the same as `|help nvim_open_win|`
	border = { '', '' ,'', ' ', '', '', '', ' ' },
	winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
	max_width = 120,
	min_width = 60,
	max_height = math.floor(vim.o.lines * 0.3),
	min_height = 1,
    };

    source = {
	path = true;
	buffer = true;
	calc = true;
	nvim_lsp = true;
	nvim_lua = true;
	vsnip = true;
	ultisnips = true;
	luasnip = true;
    };
}

--
-- CONFIGURE TAB AND SHIFT+TAB FOR COMPLETION
--

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF
