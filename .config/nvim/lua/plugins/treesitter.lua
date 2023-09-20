return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "comment",
            "csv",
            "dockerfile",
            "gitignore",
            "html",
            "json",
            "jsonc",
            "latex",
            "lua",
            "markdown",
            "python",
            "query",
            "regex",
            "sql",
            "toml",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = {
            enable = true,
        },
    },
    init = function()
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end,
}
