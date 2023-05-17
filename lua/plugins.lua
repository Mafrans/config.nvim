local lazy = require "lazy"
local cmpConfig = require "config.cmp"
local lspConfig = require "config.lsp"
local deviconsConfig = require "config.devicons"
local treesitterConfig = require "config.treesitter"

lazy.setup({
    {
        "neovim/nvim-lspconfig",
        config = cmpConfig
    },
    { "hoob3rt/lualine.nvim" },
    { "preservim/nerdtree" },
    { "preservim/nerdcommenter" },
    { "Xuyuanp/nerdtree-git-plugin" },
    {
        "kyazdani42/nvim-web-devicons",
        config = deviconsConfig
    },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
    {
        "hrsh7th/nvim-cmp",
        config = lspConfig
    },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        "rakr/vim-one",
        lazy = false
    },
    {
        "Mofiqul/dracula.nvim",
	lazy = false
    },
    { "folke/twilight.nvim" },
    { "norcalli/nvim-colorizer.lua" },
    { "sunjon/shade.nvim" },
    { "jghauser/mkdir.nvim" },
    { "romgrk/barbar.nvim" },
    { "moll/vim-bbye" },
    {
        "nvim-treesitter/nvim-treesitter",
        cmd = "TSUpdate",
        config = treesitterConfig
    },
    { "folke/trouble.nvim" },
    { "nvim-lua/plenary.nvim" },
    { "lewis6991/gitsigns.nvim" },
    { "nvim-telescope/telescope.nvim" },
    {
        "zbirenbaum/copilot.lua",
        event = { "VimEnter" },
    },
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua", "nvim-cmp" },
    },
    { "Thyrum/vim-stabs" }
})
