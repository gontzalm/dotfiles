return {
    "stevearc/conform.nvim",
    cmd = { "ConformInfo" },
    event = { "BufWritePre" },
    opts = {
        formatters_by_ft = {
            html = { "prettierd" },
            json = { "prettierd" },
            jsonc = { "prettierd" },
            markdown = { "prettierd" },
            python = { "isort", "blackd" },
            yaml = { "prettierd" },
        },
        format_on_save = { timeout_ms = 500, lsp_fallback = true },
        formatters = {
            blackd = { command = "blackd-client" },
            isort = { prepend_args = { "--profile", "black" } },
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
