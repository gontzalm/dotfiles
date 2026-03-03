return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    opts = {
        formatters_by_ft = {
            html = { "prettierd" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            lua = { lsp_format = "prefer" },
            markdown = { "prettierd" },
            python = { "ruff_organize_imports", lsp_format = "last" },
            toml = { "taplo" },
            yaml = { "prettierd" },
        },
        format_on_save = { timeout_ms = 5000 },
        formatters = {
            prettierd = {
                env = { PRETTIERD_DEFAULT_CONFIG = vim.fn.expand("~/.config/nvim/config/.prettierrc.toml") },
            },
            shfmt = {
                prepend_args = { "-i", "2", "-ci", "-bn" },
            },
        },
    },
    init = function()
        vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
}
