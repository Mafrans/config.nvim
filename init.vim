 CONFIGURE PLUGINS
"lua require('plugins')

inoremap jj <Esc>
nnoremap <c-t> :tabe<CR>
nnoremap <silent> <c-j> :BufferPrevious<cr>
nnoremap <silent> <c-l> :BufferNext<cr>
nnoremap <silent> <c-1> :BufferGoto 1<cr>
nnoremap <silent> <c-2> :BufferGoto 2<cr>
nnoremap <silent> <c-3> :BufferGoto 3<cr>
nnoremap <silent> <c-4> :BufferGoto 4<cr>
nnoremap <silent> <c-5> :BufferGoto 5<cr>
nnoremap <silent> <c-6> :BufferGoto 6<cr>
nnoremap <silent> <c-7> :BufferGoto 7<cr>
nnoremap <silent> <c-8> :BufferGoto 8<cr>
nnoremap <silent> <c-9> :BufferLast<cr> 
nnoremap <silent> <c-p> :BufferPin<cr>
nnoremap <silent> <c-w> :BufferClose<cr>
nnoremap <a-j> <C-W><C-J>
nnoremap <a-k> <C-W><C-K>
nnoremap <a-l> <C-W><C-L>
nnoremap <a-h> <C-W><C-H>
nnoremap ;ff :Telescope find_files<cr>
nnoremap ;fg :Telescope live_grep<cr>
nnoremap ;fb :Telescope buffers<cr>
nnoremap ;fh :Telescope help_tags<cr>
nnoremap ;nn :NERDTree<cr>
nnoremap ;nt :NERDTreeToggle<cr>
nnoremap ;nf :NERDTreeFind<cr>
nnoremap <C-_> <plug>NERDCommenterToggle<cr>
 
let mapleader=","
set number
set termguicolors
set hidden
set shiftwidth=2
set mouse+=a
set completeopt=menu,menuone,noselect
filetype plugin on

" SET THEME TO 'one'
let g:airline_theme='one'
colorscheme one
set background=dark

