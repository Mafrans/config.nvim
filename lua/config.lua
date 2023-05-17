local opt = vim.opt
local keymap = vim.keymap

-- set leader to space
vim.g.mapleader = " "

-- set color scheme
vim.cmd("colorscheme dracula")

-- options
opt.number = true
opt.background = "dark"
opt.autoindent = true
opt.cursorline = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.wildignore = { "*/cache/*", "*/tmp/*", "*/node_modules/*", "*/dist/*" }

-- keybindings
keymap.set("i", "jj", "<Esc>")
keymap.set("n", "<c-t>", ":tabe<CR>")
keymap.set("n", "<c-j>", ":BufferPrevious<cr>")
keymap.set("n", "<c-l>", ":BufferNext<cr>")
for i = 1, 9 do
    keymap.set("n",
        string.format("<c-%d>", i),
        string.format(":BufferGoto %d <cr>", i)
    )
end
keymap.set("n", "<c-w>", ":BufferClose<cr>")
keymap.set("n", "<a-j>", "<C-W><C-J>")
keymap.set("n", "<a-k>", "<C-W><C-K>")
keymap.set("n", "<a-l>", "<C-W><C-L>")
keymap.set("n", "<a-h>", "<C-W><C-H>")
keymap.set("n", ";ff", ":Telescope find_files<cr>")
keymap.set("n", ";fg", ":Telescope live_grep<cr>")
keymap.set("n", ";fb", ":Telescope buffers<cr>")
keymap.set("n", ";fh", ":Telescope help_tags<cr>")
keymap.set("n", ";nn", ":NERDTree<cr>")
keymap.set("n", ";nt", ":NERDTreeToggle<cr>")
keymap.set("n", ";nf", ":NERDTreeFind<cr>")
keymap.set("n", "<C-_>", "<plug>NERDCommenterToggle<cr>")
