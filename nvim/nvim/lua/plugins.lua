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
			-- "lspkind.nvim",
			-- "hrsh7th/cmp-nvim-lsp", -- lsp auto-completion
			-- "hrsh7th/cmp-buffer", -- buffer auto-completion
			-- "hrsh7th/cmp-path", -- path auto-completion
			-- "hrsh7th/cmp-cmdline", -- cmdline auto-completion
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
        config = function () 
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "go", "python", "swift", "yaml", "json" },
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

    -- todo-comments
    {
        "folke/todo-comments.nvim",
        lazy = true,
        event = { "User FileOpened" },
        config = function()
            require("todo-comments").setup()
        end,
    }, 

    -- neodim:
    {
        "zbirenbaum/neodim",
        lazy = true,
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                alpha = 0.75,
                blend_color = "#000000",
                update_in_insert = {
                    enable = true,
                    delay = 100,
                },
                hide = {
                    virtual_text = true,
                    signs = false,
                    underline = false,
                },
            })
        end,
    },
})


