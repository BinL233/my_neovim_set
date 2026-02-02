return {
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
    }
}
