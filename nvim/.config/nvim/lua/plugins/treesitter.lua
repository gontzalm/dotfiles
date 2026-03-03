return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
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
            "nu",
            "python",
            "query",
            "regex",
            "sql",
            "toml",
            "vhs",
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
    main = "nvim-treesitter.configs",
    init = function()
        vim.o.foldmethod = "expr"
        vim.o.foldexpr = "nvim_treesitter#foldexpr()"
    end,
}
