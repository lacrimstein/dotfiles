-- Appearance
vim.o.background = "dark"
vim.opt.number = true

-- Formatting
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Keymap
vim.keymap.set( 'n', '<C-d>', ':Pick explorer<CR>', { silent=true } )
vim.keymap.set( 'n', '<C-j>', '<C-w>j' )
vim.keymap.set( 'n', '<C-k>', '<C-w>k' )
vim.keymap.set( 'n', '<C-h>', '<C-w>h' )
vim.keymap.set( 'n', '<C-l>', '<C-w>l' )
vim.keymap.set( 'n', '<Tab>', '<Cmd>tabnext<CR>', { silent=true} )
vim.keymap.set( 'n', '<S-Tab>', '<Cmd>tabprev<CR>', { silent=true} )
vim.keymap.set( 'n', '<F1>', '<Cmd>tabnew<CR>', { silent=true} )

vim.diagnostic.config( {
    virtual_text = true,
    signs = {
        text = {
            [ vim.diagnostic.severity.ERROR ] = "󰅙",
            [ vim.diagnostic.severity.WARN ] = "",
        }
    }
} )

-- LSPs
vim.lsp.config[ 'clangd' ] = {
    cmd = {
        'clangd',
        '--compile-commands-dir', '/src',
        '--background-index',
        '--background-index-priority', 'normal',
    },
    filetypes = { 'c', 'cpp', 'h', 'hpp' },
    root_markers = { { '.git', 'compile_commands.json' } },
}

vim.lsp.config[ 'python-lsp-server' ] = {
    cmd = { 'pylsp' },
    filetypes = { 'python' },
    root_markers = { { '.git' } },
    settings = {
    }
}

vim.lsp.enable( 'clangd' )
vim.lsp.enable( 'python-lsp-server' )

---- PLUGINS ----
-- Bootstrap lazy.nvim
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

-- Setup lazy.nvim
require( "lazy" ).setup( {
    {
        "morhetz/gruvbox",
        init = function()
            vim.cmd.colorscheme( "gruvbox" )
            vim.cmd( 'highlight Normal guibg=NONE ctermbg=NONE' )
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            options = {
                theme = "gruvbox",
            },
            tabline = {
                lualine_a = { 
                    {
                        'tabs',
                        mode = 1,
                    }
                }
            },
        }
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        opts = {
            sources = { 
                default = { 'lsp', 'path' },
            },
            signature = {
                enabled = true,
            },
            fuzzy = {
                implementation = "lua",
            },
            completion = {
                documentation = {
                    auto_show = true
                }
            },
        }
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
          "TmuxNavigateLeft",
          "TmuxNavigateDown",
          "TmuxNavigateUp",
          "TmuxNavigateRight",
          "TmuxNavigatePrevious",
          "TmuxNavigatorProcessList",
        },
        keys = {
          { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
          { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
          { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
          { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
          { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },
    {
        "nvim-mini/mini.nvim",
        version = false,
        init = function()
            require( "mini.pick" ).setup()
            require( "mini.extra" ).setup()
            vim.keymap.set( 'n', 'gD', function() MiniExtra.pickers.lsp( { scope='definition' } ) end )
        end,
    },
    {
        "hedyhli/outline.nvim",
        init = function()
            require( "outline" ).setup( {
                outline_window = {
                    width = 20,
                },
                outline_items = {
                    show_symbol_details = false,
                },
                symbol_folding = {
                    autofold_depth = 2,
                },
            } )
            vim.keymap.set( 'n', '<c-t>', "<cmd>Outline<cr>", { silent=true } )
        end
    },
    {
        "vim-scripts/a.vim",
    },
} )

