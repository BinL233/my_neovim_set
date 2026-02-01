local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- scheme
    "tanvirtin/monokai.nvim",

    -- Vscode-like pictograms
	{
		"onsails/lspkind.nvim",
		event = { "VimEnter" },
	},
	-- Auto-completion engine
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"lspkind.nvim",
			"hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			"hrsh7th/cmp-buffer", -- buffer auto-completion
			"hrsh7th/cmp-path", -- path auto-completion
			"hrsh7th/cmp-cmdline", -- cmdline auto-completion
		},
		config = function()
			require("config.nvim-cmp")
		end,
	},
	-- Code snippet engine
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
	},

    -- LSP manager
	-- "williamboman/mason.nvim",
	-- "williamboman/mason-lspconfig.nvim",
	-- "neovim/nvim-lspconfig",

    -- {
    --    "ggandor/leap.nvim",
    --    lazy = true,
    --    keys = { "E", "R", "W", "dE", "dR", "yE", "yR", "cE", "cR" },
    --    config = function()
    --        require("leap").opts.highlight_unlabeled_phase_one_targets = true
    --        -- leap.add_default_mappings()
    --        vim.keymap.set({ "x", "o", "n" }, "E", "<Plug>(leap-forward-to)")
    --        vim.keymap.set({ "x", "o", "n" }, "R", "<Plug>(leap-backward-to)")
    --        vim.keymap.set({ "x", "o", "n" }, "W", "<Plug>(leap-from-window)")
    --    end,
    --},
    -- nvim-ts-rainbow2
    {
        "HiPhish/nvim-ts-rainbow2",
        -- Bracket pair rainbow colorize
        lazy = true,
        event = { "User FileOpened" },
    },

    -- nvim-treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local status_ok, configs = pcall(require, "nvim-treesitter.configs")
            if not status_ok then
                return
            end

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "go", "python", "swift", "yaml", "json", "markdown" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    --nvim-treesitter-context
    {
        "romgrk/nvim-treesitter-context",
        lazy = true,
        event = { "User FileOpened" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                throttle = true,
                max_lines = 0,
                patterns = {
                    default = {
                        "class",
                        "function",
                        "method",
                    },
                },
            })
        end,
    },

    {
        "karb94/neoscroll.nvim",
        opts = {
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
            hide_cursor = true,
            stop_eof = true,
            easing_function = "quadratic",
        },
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
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      config = function()
        require("nvim-tree").setup {}
      end,
    },

    -- "github/copilot.vim",

    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "nvim-lua/plenary.nvim", branch = "master" },
        },
        build = "make tiktoken",
        opts = {
            temperature = 0.1,           -- Lower = focused, higher = creative
            window = {
                layout = 'vertical',       -- 'vertical', 'horizontal', 'float'
                width = 0.3,              -- 50% of screen width
            },
            auto_insert_mode = true,     -- Enter insert mode when opening
        },
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
       -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
        
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {},
    },

    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup {
              signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
              },
              signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
              },
              signs_staged_enable = true,
              signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
              numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
              linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
              word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
              watch_gitdir = {
                follow_files = true
              },
              auto_attach = true,
              attach_to_untracked = false,
              current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
              current_line_blame_opts = {
                virt_text = true,
                virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                delay = 1000,
                ignore_whitespace = false,
                virt_text_priority = 100,
                use_focus = true,
              },
              current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
              sign_priority = 6,
              update_debounce = 100,
              status_formatter = nil, -- Use default
              max_file_length = 40000, -- Disable if file is longer than this (in lines)
              preview_config = {
                -- Options passed to nvim_open_win
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
              },
            }
        end
    }
})


