local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
end
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    {
        "rebelot/kanagawa.nvim",
        config = function()
            vim.cmd.colorscheme("kanagawa")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main"
    },
    {
        "MeanderingProgrammer/treesitter-modules.nvim",
        config = function()
            require("treesitter-modules").setup({

            ensure_installed = {"c", "lua", "vim", "vimdoc", "query",},
            auto_install = true,

            highlight = {
                enable = true,

            },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<Leader>ss",
                    node_incremental = "<Leader>si",
                    scope_incremental = "<Leader>sc",
                    node_decremental = "<Leader>sd",
                },
            },


            })
        end,

    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        config = function()
            require("nvim-treesitter-textobjects").setup({
                select = {
                    enable = true,

                    lookahead = true,
                    
                    selection_modes = {
                        ['@parameter.outer'] = 'v',
                        ['@function.outer'] = 'V',
                        ['@class.outer'] = '<c-v>',

                    },
                    include_surrounding_whitspace = true,
                },
            })
            
            local select = require("nvim-treesitter-textobjects.select").select_textobject

             vim.keymap.set({"x", "o"}, "af", function()
                select("@function.outer", "textobjects")
            end)
            vim.keymap.set({"x", "o"}, "if", function()
                select("@function.inner", "textobjects")
            end)
            vim.keymap.set({"x", "o"}, "ac", function()
                select("@class.outer", "textobjects")
            end)
            vim.keymap.set({"x", "o"}, "ic", function()
                select("@class.inner", "textobjects")
            end)
            vim.keymap.set({"x", "o"}, "as", function()
                select("@local.scope", "locals")
            end)
        end,

    },
    {
        "neovim/nvim-lspconfig",
        config = function()
        end,
    },
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
    },
    {
    'saghen/blink.cmp',
     dependencies = { 'rafamadriz/friendly-snippets' },

     version = '1.*',

     ---@module 'blink.cmp'
     ---@type blink.cmp.Config
     opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
     keymap = { preset = 'super-tab' },
     appearance = {
       nerd_font_variant = 'mono'
     },

     completion = { documentation = { auto_show = true} },
     sources = {
         default = {'lazydev','lsp', 'path', 'snippets', 'buffer' },
     providers = {
         lazydev = {
             name = "LazyDev",
             module = "lazydev.integrations.blink",
             -- make lazydev completions top priority (see `:h blink.cmp`)
             score_offset = 100,
         },
            }
        },
     fuzzy = { implementation = "prefer_rust_with_warning" }
    },
 opts_extend = { "sources.default" }
},
{
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
    },
},
})
